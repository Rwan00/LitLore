import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:litlore/core/errors/failures.dart';
import 'package:litlore/core/errors/firebase_auth_failure.dart';
import 'package:litlore/core/errors/google_auth_failure.dart';
import 'package:litlore/features/authentication/data/models/onboarding_model.dart';
import 'package:litlore/features/authentication/data/repos/authentication_repo/authentication_repo.dart';

import '../../../../../core/network/remote/google_signin_service.dart';

class AuthenticationRepoImpl implements AuthenticationRepo {
  final FirebaseAuth _auth = GoogleSignInService.auth;

  User? get currentUser => _auth.currentUser;

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

      // Send verification email
      final verificationResult = await verifyEmail();
      return verificationResult.fold(
            (failure) => left(failure),
            (_) => right(userCredential.user),
      );
    } on FirebaseAuthException catch (err) {
      log('Firebase Auth Error in signUpWithEmail: ${err.code} - ${err.message}');
      return left(FirebaseAuthFailure.fromFirebaseAuthException(err));
    } catch (error) {
      log('General Error in signUpWithEmail: $error');
      return left(FirebaseAuthFailure(
        errorMsg: 'An unexpected error occurred during sign up: $error',
      ));
    }
  }

  @override
  Future<Either<Failures, void>> verifyEmail() async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        return left(FirebaseAuthFailure(errorMsg: 'No user is currently signed in'));
      }

      if (user.emailVerified) return right(null);

      await user.sendEmailVerification();
      return right(null);
    } on FirebaseAuthException catch (err) {
      return left(FirebaseAuthFailure.fromFirebaseAuthException(err));
    } catch (error) {
      return left(FirebaseAuthFailure(errorMsg: 'Failed to send verification email: $error'));
    }
  }

  @override
  Future<Either<String, bool>> checkEmailVerification() async {
    try {
      final user = currentUser;
      if (user == null) return left("No user is currently signed in");

      await user.reload();
      final updatedUser = _auth.currentUser;

      if (updatedUser == null || !updatedUser.emailVerified) {
        return left("Email not yet verified. Please check your inbox and verify your email.");
      }

      return right(true);
    } catch (error) {
      return left("Error checking email verification: $error");
    }
  }

  @override
  Future<Either<Failures, User?>?> signInWithGoogle() async {
    try {
      final userCredential = await GoogleSignInService.signInWithGoogle();
      if (userCredential == null) {
        return null; // cancelled
      }
      return right(userCredential.user);
    } on FirebaseAuthException catch (err) {
      return left(FirebaseGoogleAuthFailure.fromFirebaseAuthException(err));
    } catch (error) {
      return left(FirebaseGoogleAuthFailure(
        errorMsg: 'Failed to sign in with Google: $error',
      ));
    }
  }

  @override
  Future<Either<Failures, void>> signOut() async {
    try {
      await GoogleSignInService.signOut();
      return right(null);
    } catch (error) {
      return left(FirebaseAuthFailure(errorMsg: 'Failed to sign out: $error'));
    }
  }

  // Convenience getters
  bool get isSignedIn => currentUser != null;
  bool get isEmailVerified => currentUser?.emailVerified ?? false;
  String? get userEmail => currentUser?.email;
  String? get userDisplayName => currentUser?.displayName;

  @override
  Future<Either<Failures, User?>?> linkGoogleAccount() async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        return left(FirebaseAuthFailure(
          errorMsg: 'No user is currently signed in',
        ));
      }

      // Use the service to perform Google sign-in
      final googleUserCredential = await GoogleSignInService.signInWithGoogle();
      if (googleUserCredential == null) {
        return null; // cancelled by user
      }

      final googleCredential = googleUserCredential.credential;
      if (googleCredential == null) {
        return left(FirebaseGoogleAuthFailure(
          errorMsg: "No Google credentials found",
        ));
      }

      try {
        // Link Google account with current Firebase user
        final linkedCredential = await user.linkWithCredential(googleCredential);
        log("Google account linked successfully");
        return right(linkedCredential.user);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'credential-already-in-use') {
          return left(FirebaseGoogleAuthFailure(
            errorMsg: "This Google account is already linked to another account",
          ));
        } else if (e.code == 'provider-already-linked') {
          return left(FirebaseGoogleAuthFailure(
            errorMsg: "Google account is already linked to this user",
          ));
        }
        return left(FirebaseGoogleAuthFailure.fromFirebaseAuthException(e));
      }
    } on FirebaseAuthException catch (err) {
      log("Firebase Auth Error in linkGoogleAccount: ${err.code} - ${err.message}");
      return left(FirebaseGoogleAuthFailure.fromFirebaseAuthException(err));
    } catch (error) {
      log("General Error in linkGoogleAccount: $error");
      return left(FirebaseGoogleAuthFailure(
        errorMsg: 'Failed to link Google account: $error',
      ));
    }
  }

}
