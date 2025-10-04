import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:litlore/core/errors/failures.dart';
import 'package:litlore/core/errors/firebase_auth_failure.dart';
import 'package:litlore/core/errors/google_auth_failure.dart';
import 'package:litlore/core/network/remote/google_signin_service.dart';
import 'package:litlore/core/utils/app_consts.dart';
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
      await verifyEmail();
      return right(userCredential.user);
    } on FirebaseAuthException catch (err) {
      log(err.toString());
      return left(FirebaseAuthFailure.fromFirebaseAuthException(err));
    } catch (error) {
      return left(FirebaseAuthFailure(errorMsg: error.toString()));
    }
  }

  @override
  Future<Either<Failures, void>> verifyEmail() async {
    try {
      await _auth.currentUser!.sendEmailVerification();
      return right(null);
    } on FirebaseAuthException catch (err) {
      log(err.toString());
      return left(FirebaseAuthFailure.fromFirebaseAuthException(err));
    } catch (error) {
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
        return right(true);
      }

      // Try to link Google account
      final linkedUser = await linkGoogleAccount();
      if (linkedUser == null) {
        return left("Sign-in aborted. Google is now crying in a corner.");
      }

      return linkedUser.fold(
        (failure) => left(failure.errorMsg),
        (user) => right(true),
      );
    } catch (error) {
      log("Error checking email verification: $error");
      return left("Tried verifying your email, but it ghosted us.");
    }
  }

  @override
  Future<Either<Failures, User?>?> linkGoogleAccount() async {
    try {
      final googleUser = await GoogleSignInService.getGoogleSigninAccount();
      if (googleUser == null) return null;

      final googleAuth = await googleUser.authentication;
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
        await _auth.currentUser?.linkWithCredential(credential);
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

      _accessToken = accessToken;
      _tokenExpiryTime = DateTime.now().add(const Duration(hours: 1));

      log(
        "Google account linked successfully. Access token: ${_accessToken != null ? 'Available:$_accessToken' : 'Not available'}",
      );
      return right(_auth.currentUser);
    } on FirebaseAuthException catch (err) {
      log("Firebase Auth Error: ${err.toString()}");
      return left(FirebaseGoogleAuthFailure.fromFirebaseAuthException(err));
    } catch (error) {
      log("General Error: ${error.toString()}");
      return left(FirebaseGoogleAuthFailure(errorMsg: error.toString()));
    }
  }

  @override
  Future<Either<Failures, User?>?> signInWithGoogle() async {
    try {
      final userCredential = await GoogleSignInService.signInWithGoogle();
      if (userCredential == null) return null;

      return right(userCredential.user);
    } on FirebaseAuthException catch (err) {
      logger.e("${err.code}, ${ err.message}");
      return left(FirebaseGoogleAuthFailure.fromFirebaseAuthException(err));
    } catch (error) {
      logger.e(error);
      return left(
        FirebaseGoogleAuthFailure(
          errorMsg: 'Failed to sign in with Google: $error',
        ),
      );
    }
  }

  Future<String?> refreshGoogleBooksToken() async {
    try {
      final currentUser = await GoogleSignInService.getGoogleSigninAccount();
      if (currentUser == null) return null;

      
      final authorization = await currentUser.authorizationClient
          .authorizationForScopes([
            'email',
            'profile',
            'https://www.googleapis.com/auth/books',
          ]);

      final _accessToken = authorization?.accessToken;

      _tokenExpiryTime = DateTime.now().add(const Duration(hours: 1));
      return _accessToken;
    } catch (error) {
      log("Error refreshing Google Books token: $error");
      return null;
    }
  }
}
