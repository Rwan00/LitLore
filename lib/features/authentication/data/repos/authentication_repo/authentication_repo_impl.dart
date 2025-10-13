import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:litlore/core/errors/failures.dart';
import 'package:litlore/core/errors/firebase_auth_failure.dart';
import 'package:litlore/core/errors/google_auth_failure.dart';
import 'package:litlore/core/network/local/cache_helper.dart';
import 'package:litlore/core/network/remote/google_signin_service.dart';

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

      // Extract and save tokens
      if (user != null) {
        final idToken = await _getFirebaseIdToken(user);
        final refreshToken = user.refreshToken;

        await _saveTokensToCache(
          accessToken: idToken,
          refreshToken: refreshToken,
        );
      }

      await verifyEmail();
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
  Future<Either<Failures, void>> verifyEmail() async {
    try {
      await _auth.currentUser!.sendEmailVerification();
      return right(null);
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

      if (updatedUser == null || !updatedUser.emailVerified) {
        return left(
          "Still unverified? That's like reading half a book and stopping!",
        );
      }

      // Check if Google account is already linked
      final hasGoogleProvider = updatedUser.providerData.any(
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

      return linkedUser.fold(
        (failure) => left(failure.errorMsg),
        (user) async {
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
        },
      );
    } catch (error) {
      log("❌ Error checking email verification: $error");
      return left("Tried verifying your email, but it ghosted us.");
    }
  }

  @override
  Future<Either<Failures, User?>?> linkGoogleAccount() async {
    try {
      final googleUser = await GoogleSignInService.getGoogleSigninAccount();
      if (googleUser == null) return null;

      final googleAuth = googleUser.authentication;
      final authorization = await googleUser.authorizationClient
          .authorizationForScopes([
            'email',
            'profile',
            'https://www.googleapis.com/auth/books',
          ]);

      final accessToken = authorization?.accessToken;
      final credential = GoogleAuthProvider.credential(
        accessToken: accessToken,
        idToken: googleAuth.idToken,
      );

      // Check if this Google account is already linked to another Firebase account
      try {
        final linkedUserCredential =
            await _auth.currentUser?.linkWithCredential(credential);
        final linkedUser = linkedUserCredential?.user;

        // Extract and save tokens after linking
        if (linkedUser != null) {
          final idToken = await _getFirebaseIdToken(linkedUser);
          final refreshToken = linkedUser.refreshToken;

          await _saveTokensToCache(
            accessToken: idToken,
            refreshToken: refreshToken,
          );

          // Store Google Books access token separately
          _accessToken = accessToken;
          _tokenExpiryTime = DateTime.now().add(const Duration(hours: 1));

          log(
            "✅ Google account linked successfully. Tokens saved.",
          );
        }

        return right(linkedUser);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'credential-already-in-use') {
          return left(
            FirebaseGoogleAuthFailure(
              errorMsg: "Hmm… Google says it doesn't know this email. Awkward!",
            ),
          );
        }
        rethrow;
      }
    } on FirebaseAuthException catch (err) {
      log("❌ Firebase Auth Error: ${err.toString()}");
      return left(FirebaseGoogleAuthFailure.fromFirebaseAuthException(err));
    } catch (error) {
      log("❌ General Error: ${error.toString()}");
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