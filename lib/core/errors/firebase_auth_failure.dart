import 'package:firebase_auth/firebase_auth.dart';

import 'failures.dart';

class FirebaseAuthFailure extends Failures {
  FirebaseAuthFailure({required super.errorMsg});

  factory FirebaseAuthFailure.fromFirebaseAuthException(
      FirebaseAuthException authException) {
    switch (authException.code) {
      case "invalid-email":
        return FirebaseAuthFailure(
            errorMsg: "If this is your email, then I’m the CEO of the Internet. Try again!");
      case "user-disabled":
        return FirebaseAuthFailure(
            errorMsg: "Access denied! Your account went rogue, and we had to lock it in the library basement.");
      case "user-not-found":
        return FirebaseAuthFailure(
            errorMsg: "Even Sherlock Holmes couldn’t find this user. Double-check your details!");
      case "wrong-password":
        return FirebaseAuthFailure(
            errorMsg: "Wrong password! Even my pet goldfish could do better.");
      case "email-already-in-use":
        return FirebaseAuthFailure(
            errorMsg: "Déjà vu! This email is already part of our story.");
      case "weak-password":
        return FirebaseAuthFailure(
            errorMsg: "This password is like a plot twist everyone saw coming. Try again!");
      case "too-many-requests":
        return FirebaseAuthFailure(
            errorMsg: "Whoa there, speed reader! Give the system a breather!");
      case "operation-not-allowed":
        return FirebaseAuthFailure(
            errorMsg: "Oops! That move is as forbidden as spoilers in a book club.");
      case "network-request-failed":
        return FirebaseAuthFailure(
            errorMsg: "No internet detected. Maybe try shouting at your router—it works 60% of the time."
);
      default:
        return FirebaseAuthFailure(
            errorMsg: "Authentication failed! Even the secret library archives wouldn’t let you in.");
    }
  }
}