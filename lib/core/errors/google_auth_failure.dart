import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:litlore/core/errors/failures.dart';

class FirebaseGoogleAuthFailure extends Failures {
  FirebaseGoogleAuthFailure({required super.errorMsg});

  factory FirebaseGoogleAuthFailure.fromFirebaseAuthException(
    FirebaseAuthException authException,
  ) {
    switch (authException.code) {
      case "provider-already-linked":
        return FirebaseGoogleAuthFailure(
          errorMsg:
              "You've already linked Google to this account. No need to double-knot your shoes!",
        );
      case "credential-already-in-use":
        return FirebaseGoogleAuthFailure(
          errorMsg:
              "Nice try, but these Email have already found a happy home!",
        );
      case "requires-recent-login":
        return FirebaseGoogleAuthFailure(errorMsg: getErrorMessage());
      case "invalid-credential":
        return FirebaseGoogleAuthFailure(
          errorMsg:
              "Something's off with these credentials. Did Google change the locks?",
        );
      case "user-disabled":
        return FirebaseGoogleAuthFailure(
          errorMsg:
              "Access denied! Your account went rogue, and we had to lock it in the library basement.",
        );
      case "operation-not-allowed":
        return FirebaseGoogleAuthFailure(
          errorMsg:
              "Oops! That request just got rejected faster than a terrible book idea.",
        );

      default:
        return FirebaseGoogleAuthFailure(
          errorMsg: "Signing failed! Even Google couldn’t sneak past this one.",
        );
    }
  }

  factory FirebaseGoogleAuthFailure.fromGoogleSignInException(
  GoogleSignInException authException,
) {
  switch (authException.code) {
    case GoogleSignInExceptionCode.unknownError:
      return FirebaseGoogleAuthFailure(
        errorMsg:
            "Google just dropped the plot twist of the century — something went wrong, and even it’s confused.",
      );
    case GoogleSignInExceptionCode.canceled:
      return FirebaseGoogleAuthFailure(
        errorMsg:
            "You canceled the sign-in faster than a reader closing a bad sequel!",
      );
    case GoogleSignInExceptionCode.interrupted:
      return FirebaseGoogleAuthFailure(
        errorMsg:
            "Hold up! Something interrupted your sign-in — maybe a dramatic cliffhanger?",
      );
    case GoogleSignInExceptionCode.clientConfigurationError:
      return FirebaseGoogleAuthFailure(
        errorMsg:
            "It seems Google misplaced the manual — the sign-in setup isn’t quite right!",
      );
    case GoogleSignInExceptionCode.providerConfigurationError:
      return FirebaseGoogleAuthFailure(
        errorMsg:
            "Google’s settings are having an identity crisis. Maybe it needs a motivational quote.",
      );
    case GoogleSignInExceptionCode.uiUnavailable:
      return FirebaseGoogleAuthFailure(
        errorMsg:
            "The sign-in screen took a coffee break — no UI in sight!",
      );
    case GoogleSignInExceptionCode.userMismatch:
      return FirebaseGoogleAuthFailure(
        errorMsg:
            "Oops! The account you chose doesn’t match — it’s like trying to put the wrong bookmark in the wrong book.",
      );
    default:
      return FirebaseGoogleAuthFailure(
        errorMsg:
            "Something went sideways in the Googleverse — try again before it vanishes into another dimension!",
      );
  }
}

}

String getErrorMessage() {
  List<String> messages = [
    "Whoa there, time traveler! You need to log in again before making history.",
    "Your session is older than a dusty library book—log in again!",
    "We need a fresh login! Your last one is practically a classic novel by now.",
    "Security check! We just need to make sure you’re still you.",
    "Your login expired faster than a plot twist reveal—try again!",
    "Before you continue, we need to verify you're not a sleepwalking bookworm.",
    "This action requires a recent login. Your last one is vintage!",
    "Your session timed out—probably went to grab coffee. Log in again!",
    "Re-login needed! Don’t worry, no passwords were harmed in the making of this message.",
    "Before proceeding, please confirm you’re not an imposter from another novel.",
  ];

  Random random = Random();
  return messages[random.nextInt(messages.length)];
}
