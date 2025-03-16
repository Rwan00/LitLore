import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:litlore/core/errors/google_auth_failure.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../../core/errors/firebase_auth_failure.dart';

import '../../models/onboarding_model.dart';
import 'authentication_repo.dart';

class AuthenticationRepoImpl implements AuthenticationRepo {
  @override
  bool onPageChange({required int index}) {
    bool isLast = false;
    if (index == onBoardingList.length - 1) {
      isLast = true;
    } else {
      isLast = false;
    }
    return isLast;
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? get currentUser => _auth.currentUser;
  String? _accessToken;
  DateTime? _tokenExpiryTime;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['https://www.googleapis.com/auth/books'],
  );

  @override
  Future<Either<Failures, User?>> signUpWithEmail(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await userCredential.user?.sendEmailVerification();

      return right(userCredential.user);
    } on FirebaseAuthException catch (err) {
      log(err.toString());
      return left(FirebaseAuthFailure.fromFirebaseAuthException(err));
    } catch (error) {
      return left(
        FirebaseAuthFailure(
          errorMsg: error.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<String, void>> checkEmailVerification() async {
    await currentUser?.reload();
    final updatedUser = currentUser;

    if (updatedUser != null && updatedUser.emailVerified) {
      final linkedUser = await linkGoogleAccount();
      if (linkedUser != null) {
        return right(null);
      } else {
        return left("Hmm… Google says it doesn’t know this email. Awkward!");
      }
    } else {
      return left(
          "Still unverified? That’s like reading half a book and stopping!");
      //_showVerificationDialog(user);
    }
  }

  @override
  Future<Either<Failures, User?>?> linkGoogleAccount() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.currentUser?.linkWithCredential(credential);

      _accessToken = googleAuth.accessToken;
      _tokenExpiryTime = DateTime.now().add(const Duration(hours: 1));

      return right(_auth.currentUser);
    } on FirebaseAuthException catch (err) {
      log(err.toString());
      return left(FirebaseGoogleAuthFailure.fromFirebaseAuthException(err));
    } catch (error) {
      return left(
        FirebaseGoogleAuthFailure(
          errorMsg: error.toString(),
        ),
      );
    }
  }
}
