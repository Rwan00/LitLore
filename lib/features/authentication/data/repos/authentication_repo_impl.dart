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
import 'package:litlore/features/authentication/data/repos/authentication_repo.dart';

class AuthenticationRepoImpl implements AuthenticationRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // FIXED: Separate cache keys for different tokens
  static const String _googleBooksTokenKey = 'google_books_access_token';
  static const String _googleBooksTokenExpiryKey = 'google_books_token_expiry';

  User? get currentUser => _auth.currentUser;

  /// FIXED: Retrieve Google Books token from cache with expiry check
  Future<String?> get googleBooksAccessToken async {
    try {
      final token = await AppCacheHelper.getSecureString(
        key: _googleBooksTokenKey,
      );

      if (token == null || token.isEmpty) {
        log('⚠️ No Google Books token found in cache');
        return null;
      }

      // Check token expiry
      final expiryString = await AppCacheHelper.getSecureString(
        key: _googleBooksTokenExpiryKey,
      );

      if (expiryString != null) {
        final expiryTime = DateTime.parse(expiryString);
        if (DateTime.now().isAfter(expiryTime)) {
          log('⚠️ Google Books token expired');
          return null;
        }
      }

      log('✅ Valid Google Books token retrieved from cache');
      return token;
    } catch (e) {
      log('❌ Error retrieving Google Books token: $e');
      return null;
    }
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

  /// Save Firebase tokens to cache (ID token as access token)
  Future<void> _saveFirebaseTokensToCache({
    required String? idToken,
    required String? refreshToken,
  }) async {
    try {
      if (idToken != null && idToken.isNotEmpty) {
        await AppCacheHelper.cacheSecureString(
          key: AppCacheHelper.accessTokenKey,
          value: idToken,
        );
        log('✅ Firebase ID token saved to cache');
      }

      if (refreshToken != null && refreshToken.isNotEmpty) {
        await AppCacheHelper.cacheSecureString(
          key: AppCacheHelper.refreshTokenKey,
          value: refreshToken,
        );
        log('✅ Firebase refresh token saved to cache');
      }
    } catch (e) {
      log('❌ Error saving Firebase tokens to cache: $e');
    }
  }

  /// FIXED: Save Google Books access token with expiry
  Future<void> _saveGoogleBooksToken(String accessToken) async {
    try {
      await AppCacheHelper.cacheSecureString(
        key: _googleBooksTokenKey,
        value: accessToken,
      );

      // Store expiry time (Google tokens typically last 1 hour)
      final expiryTime = DateTime.now().add(const Duration(minutes: 55));
      await AppCacheHelper.cacheSecureString(
        key: _googleBooksTokenExpiryKey,
        value: expiryTime.toIso8601String(),
      );

      log('✅ Google Books access token saved with expiry: $expiryTime');
    } catch (e) {
      log('❌ Error saving Google Books token: $e');
    }
  }

  /// FIXED: Method to refresh Google Books token
  Future<String?> refreshGoogleBooksToken() async {
    try {
      log('🔄 Attempting to refresh Google Books token...');

      final googleUser = await GoogleSignInService.getGoogleSigninAccount();
      if (googleUser == null) {
        log('❌ No Google account available for token refresh');
        return null;
      }

      final authorizationClient = googleUser.authorizationClient;
      final authorization = await authorizationClient.authorizeScopes([
        'email',
        'profile',
        'https://www.googleapis.com/auth/books',
      ]);

      final accessToken = authorization.accessToken;
      await _saveGoogleBooksToken(accessToken);

      log('✅ Google Books token refreshed successfully');
      return accessToken;
    } catch (e) {
      log('❌ Error refreshing Google Books token: $e');
      return null;
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
    }
  }

  @override
  Future<Either<Failures, User?>> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      return right(user);
    } on FirebaseAuthException catch (err) {
      log('❌ Firebase Auth Error: ${err.toString()}');
      return left(FirebaseAuthFailure.fromFirebaseAuthException(err));
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
        log("Google account already linked");

        // Extract and save Firebase tokens
        final idToken = await _getFirebaseIdToken(updatedUser);
        final refreshToken = updatedUser.refreshToken;

        await _saveFirebaseTokensToCache(
          idToken: idToken,
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

          await _saveFirebaseTokensToCache(
            idToken: idToken,
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
        return left(
          FirebaseGoogleAuthFailure(errorMsg: "No authenticated user found"),
        );
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

      final googleAccessToken = authorization.accessToken;
      logger.e("Google access token obtained: ${googleAccessToken.isNotEmpty}");
      log("Google access token obtained: ${googleAccessToken.isNotEmpty}");

      // FIXED: Save Google Books access token BEFORE Firebase linking
      await _saveGoogleBooksToken(googleAccessToken);

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAccessToken,
        idToken: googleAuth.idToken,
      );

      // Link the credential to the current user
      try {
        final linkedUserCredential = await currentUser.linkWithCredential(
          credential,
        );
        final linkedUser = linkedUserCredential.user;

        // Reload to get fresh data
        await linkedUser?.reload();
        final freshUser = _auth.currentUser;

        // Extract and save Firebase tokens after linking
        if (freshUser != null) {
          final idToken = await _getFirebaseIdToken(freshUser);
          final refreshToken = freshUser.refreshToken;

          await _saveFirebaseTokensToCache(
            idToken: idToken,
            refreshToken: refreshToken,
          );

          log("✅ Google account linked successfully. All tokens saved.");
          logger.e("✅ Google account linked successfully");
        }

        return right(freshUser);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'credential-already-in-use') {
          logger.e("Google account already linked to another user");
          return left(
            FirebaseGoogleAuthFailure(
              errorMsg:
                  "This Google account is already linked to another account",
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
    } on GoogleSignInException catch (error) {
      log("❌ General Error: ${error.toString()}");
      logger.e("❌ General Error: ${error.toString()}");
      return left(FirebaseGoogleAuthFailure.fromGoogleSignInException(error));
    } catch (err) {
      return left(FirebaseAuthFailure(errorMsg: err.toString()));
    }
  }

  @override
  Future<Either<Failures, User?>?> signInWithGoogle() async {
    try {
      final userCredential = await GoogleSignInService.signInWithGoogle();
      if (userCredential == null) return null;

      final user = userCredential.user;

      // Extract and save Firebase tokens
      if (user != null) {
        final idToken = await _getFirebaseIdToken(user);
        final refreshToken = user.refreshToken;

        await _saveFirebaseTokensToCache(
          idToken: idToken,
          refreshToken: refreshToken,
        );

        // FIXED: Get Google Books token after successful sign-in
        try {
          final googleUser = await GoogleSignInService.getGoogleSigninAccount();
          if (googleUser != null) {
            final authorizationClient = googleUser.authorizationClient;
            final authorization = await authorizationClient.authorizeScopes([
              'email',
              'profile',
              'https://www.googleapis.com/auth/books',
            ]);
            final googleAccessToken = authorization.accessToken;
            await _saveGoogleBooksToken(googleAccessToken);
            log('✅ Google Books token saved during sign-in');
          }
        } catch (e) {
          log('⚠️ Could not save Google Books token: $e');
        }

        log('✅ Google sign-in successful. All tokens saved.');
      }

      return right(user);
    } on FirebaseAuthException catch (err) {
      log("❌ Firebase Auth Error: ${err.code}, ${err.message}");
      return left(FirebaseGoogleAuthFailure.fromFirebaseAuthException(err));
    } on GoogleSignInException catch (error) {
      log("❌ General Error: ${error.toString()}");
      logger.e("❌ General Error: ${error.toString()}");
      return left(FirebaseGoogleAuthFailure.fromGoogleSignInException(error));
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
