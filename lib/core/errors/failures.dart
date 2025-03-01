import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class Failures {
  final String errorMsg;

  Failures({required this.errorMsg});
}

class ServerFailure extends Failures {
  ServerFailure({required super.errorMsg});

  factory ServerFailure.fromDioError(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(
            errorMsg:
                "Conneection Timeout,\n Don't worry, the server just play hide and seek with you.");
      case DioExceptionType.sendTimeout:
        return ServerFailure(
          errorMsg: "This request took too long,\n We gave up.",
        );
      case DioExceptionType.receiveTimeout:
        return ServerFailure(
          errorMsg:
              "No reply,\n Maybe the server's giving us the silent treatment.",
        );
      case DioExceptionType.badCertificate:
        return ServerFailure(
          errorMsg:
              "Certificate error,\n Looks like someone skipped their SSL class.",
        );
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          dioException.response!.statusCode!,
          dioException.response!.data,
        );
      case DioExceptionType.cancel:
        return ServerFailure(
          errorMsg: "Request canceled,\n Was it something i said?",
        );
      case DioExceptionType.connectionError:
        return ServerFailure(
          errorMsg: "We tried to connect,\n But the internet ghosted us.",
        );
      case DioExceptionType.unknown:
        return ServerFailure(
          errorMsg:
              "Something went wrong,\n Actually we don't know if it's your fault or ours, But we're always right.",
        );
    }
  }

  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(errorMsg: response["error"]["message"]);
    } else if (statusCode == 404) {
      return ServerFailure(
          errorMsg: "Your request not found, Please try again later!");
    } else if (statusCode == 500) {
      return ServerFailure(
        errorMsg:
            "Server Error..Don't worry it's our mistake, Go touch the grass until we fix the problem.",
      );
    } else {
      return ServerFailure(
        errorMsg: "Oops! Something went wrong.",
      );
    }
  }
}

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
      default:
        return FirebaseAuthFailure(
            errorMsg: "Authentication failed! Even the secret library archives wouldn’t let you in.");
    }
  }
}

