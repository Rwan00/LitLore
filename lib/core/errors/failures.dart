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
            errorMsg: "Invalid email format, Please check and try again.");
      case "user-disabled":
        return FirebaseAuthFailure(
            errorMsg: "This account has been disabled, Contact support.");
      case "user-not-found":
        return FirebaseAuthFailure(
            errorMsg: "No user found with this email, Sign up instead?");
      case "wrong-password":
        return FirebaseAuthFailure(
            errorMsg: "Incorrect password, Try again or reset it.");
      case "email-already-in-use":
        return FirebaseAuthFailure(
            errorMsg: "This email is already registered, Try logging in.");
      case "weak-password":
        return FirebaseAuthFailure(
            errorMsg: "Weak password, Try using a stronger one.");
      case "too-many-requests":
        return FirebaseAuthFailure(
            errorMsg: "Too many attempts, Please try again later.");
      case "operation-not-allowed":
        return FirebaseAuthFailure(
            errorMsg: "This operation is not allowed, Contact support.");
      default:
        return FirebaseAuthFailure(
            errorMsg: "Authentication failed, Please try again.");
    }
  }
}

