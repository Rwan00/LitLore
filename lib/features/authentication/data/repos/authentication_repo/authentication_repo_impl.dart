import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:litlore/core/errors/failures.dart';
import 'package:litlore/core/errors/firebase_auth_failure.dart';
import 'package:litlore/core/errors/google_auth_failure.dart';
import 'package:litlore/core/network/local/cache_helper.dart';
import 'package:litlore/core/network/remote/google_signin_service.dart';
import 'package:litlore/core/utils/app_consts.dart' show logger;

import 'package:litlore/features/authentication/data/models/onboarding_model.dart';
import 'package:litlore/features/authentication/data/repos/authentication_repo/authentication_repo.dart';

class AuthenticationRepoImpl implements AuthenticationRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _accessToken;
  DateTime? _tokenExpiryTime;

  User? get currentUser => _auth.currentUser;

  String? get googleBooksAccessToken {
    if (_tokenExpiryTime != null &&
        DateTime.now().isBefore(_tokenExpiryTime!)) {
      return _accessToken;
    }
    return null;
  }

  /// Extract Firebase ID token from user
  Future<String?> _getFirebaseIdToken(User? user) async {
    try {
      if (user == null) return null;
      final idToken = await user.getIdToken();
      return idToken;
    } catch (e) {
      log('❌ Error getting Firebase ID token: $e');
      return null;
    }
  }

  /// Save tokens to cache
  Future<void> _saveTokensToCache({
    required String? accessToken,
    required String? refreshToken,
  }) async {
    try {
      if (accessToken != null && accessToken.isNotEmpty) {
        await AppCacheHelper.cacheSecureString(
          key: AppCacheHelper.accessTokenKey,
          value: accessToken,
        );
        log('✅ Access token saved to cache');
      }

      if (refreshToken != null && refreshToken.isNotEmpty) {
        await AppCacheHelper.cacheSecureString(
          key: AppCacheHelper.refreshTokenKey,
          value: refreshToken,
        );
        log('✅ Refresh token saved to cache');
      }
    } catch (e) {
      log('❌ Error saving tokens to cache: $e');
    }
  }

  @override
  bool onPageChange({required int index}) {
    return index == onBoardingList.length - 1;
  }

  @override
  Future<Either<Failures, User?>> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;

      return right(user);
    } on FirebaseAuthException catch (err) {
      log('❌ Firebase Auth Error: ${err.toString()}');
      return left(FirebaseAuthFailure.fromFirebaseAuthException(err));
    } catch (error) {
      log('❌ General Error: ${error.toString()}');
      return left(FirebaseAuthFailure(errorMsg: error.toString()));
    }
  }

  @override
  Future<Either<String, bool>> checkEmailVerification() async {
    try {
      await currentUser?.reload();
      final updatedUser = currentUser;

      // Check if Google account is already linked
      final hasGoogleProvider = updatedUser!.providerData.any(
        (provider) => provider.providerId == 'google.com',
      );

      if (hasGoogleProvider) {
        log(
          "This Google account's already on chapter 5. Pick another to start fresh!",
        );

        // Extract and save tokens
        final idToken = await _getFirebaseIdToken(updatedUser);
        final refreshToken = updatedUser.refreshToken;

        await _saveTokensToCache(
          accessToken: idToken,
          refreshToken: refreshToken,
        );

        return right(true);
      }

      // Try to link Google account
      final linkedUser = await linkGoogleAccount();
      if (linkedUser == null) {
        return left("Sign-in aborted. Google is now crying in a corner.");
      }

      return linkedUser.fold((failure) => left(failure.errorMsg), (user) async {
        // Extract and save tokens after linking
        if (user != null) {
          final idToken = await _getFirebaseIdToken(user);
          final refreshToken = user.refreshToken;

          await _saveTokensToCache(
            accessToken: idToken,
            refreshToken: refreshToken,
          );
        }
        return right(true);
      });
    } catch (error) {
      log("❌ Error checking email verification: $error");
      return left("Tried verifying your email, but it ghosted us.");
    }
  }

@override
Future<Either<Failures, User?>?> linkGoogleAccount() async {
  try {
    logger.e("Starting Google account linking...");
    log("Starting Google account linking...");

    // Get current user BEFORE starting Google sign-in
    final currentUser = _auth.currentUser;
    if (currentUser == null) {
      logger.e("No current user to link Google account to");
      return left(FirebaseGoogleAuthFailure(
        errorMsg: "No authenticated user found",
      ));
    }

    // Get Google sign-in account
    final googleUser = await GoogleSignInService.getGoogleSigninAccount();
    if (googleUser == null) {
      logger.e("Google sign-in was cancelled");
      log("Google sign-in was cancelled");
      return null;
    }
    
    logger.e("Got Google user: ${googleUser.email}");
    log("Got Google user: ${googleUser.email}");

    final googleAuth = googleUser.authentication;
    final authorizationClient = googleUser.authorizationClient;
    
    // Get authorization with Books scope
    GoogleSignInClientAuthorization authorization = await authorizationClient
        .authorizeScopes([
          'email',
          'profile',
          'https://www.googleapis.com/auth/books',
        ]);

    final accessToken = authorization.accessToken;
    logger.e("Access token obtained: ${accessToken != null}");
    log("Access token obtained: ${accessToken != null}");
    
    if (accessToken == null) {
      return left(FirebaseGoogleAuthFailure(
        errorMsg: "Failed to obtain Google access token",
      ));
    }

    final credential = GoogleAuthProvider.credential(
      accessToken: accessToken,
      idToken: googleAuth.idToken,
    );

    // Link the credential to the current user
    try {
      // IMPORTANT: Use currentUser reference we got earlier
      final linkedUserCredential = await currentUser.linkWithCredential(credential);
      final linkedUser = linkedUserCredential.user;

      // Reload to get fresh data
      await linkedUser?.reload();
      final freshUser = _auth.currentUser;

      // Extract and save tokens after linking
      if (freshUser != null) {
        final idToken = await _getFirebaseIdToken(freshUser);
        final refreshToken = freshUser.refreshToken;

        await _saveTokensToCache(
          accessToken: idToken,
          refreshToken: refreshToken,
        );

        // Store Google Books access token separately
        _accessToken = accessToken;
        _tokenExpiryTime = DateTime.now().add(const Duration(hours: 1));

        log("✅ Google account linked successfully. Tokens saved.");
        logger.e("✅ Google account linked successfully");
      }

      return right(freshUser);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'credential-already-in-use') {
        logger.e("Google account already linked to another user");
        return left(
          FirebaseGoogleAuthFailure(
            errorMsg: "This Google account is already linked to another account",
          ),
        );
      } else if (e.code == 'provider-already-linked') {
        logger.e("User already has Google linked");
        return left(
          FirebaseGoogleAuthFailure(
            errorMsg: "A Google account is already linked to this user",
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        logger.e("Email already in use by another account");
        return left(
          FirebaseGoogleAuthFailure(
            errorMsg: "This email is already registered with another account",
          ),
        );
      }
      rethrow;
    }
  } on FirebaseAuthException catch (err) {
    log("❌ Firebase Auth Error: ${err.code} - ${err.message}");
    logger.e("❌ Firebase Auth Error: ${err.code} - ${err.message}");
    return left(FirebaseGoogleAuthFailure.fromFirebaseAuthException(err));
  } catch (error) {
    log("❌ General Error: ${error.toString()}");
    logger.e("❌ General Error: ${error.toString()}");
    return left(FirebaseGoogleAuthFailure(errorMsg: error.toString()));
  }
}
  @override
  Future<Either<Failures, User?>?> signInWithGoogle() async {
    try {
      final userCredential = await GoogleSignInService.signInWithGoogle();
      if (userCredential == null) return null;

      final user = userCredential.user;

      // Extract and save tokens
      if (user != null) {
        final idToken = await _getFirebaseIdToken(user);
        final refreshToken = user.refreshToken;

        await _saveTokensToCache(
          accessToken: idToken,
          refreshToken: refreshToken,
        );

        log('✅ Google sign-in successful. Tokens saved.');
      }

      return right(user);
    } on FirebaseAuthException catch (err) {
      log("❌ Firebase Auth Error: ${err.code}, ${err.message}");
      return left(FirebaseGoogleAuthFailure.fromFirebaseAuthException(err));
    } catch (error) {
      log("❌ General Error: ${error.toString()}");
      return left(
        FirebaseGoogleAuthFailure(
          errorMsg: 'Failed to sign in with Google: $error',
        ),
      );
    }
  }
}
