import 'package:dio/dio.dart';

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
                "Conneection Timeout..Please check your internet connection.");
      case DioExceptionType.sendTimeout:
        return ServerFailure(
          errorMsg: "Send Timeout..Please check your internet connection.",
        );
      case DioExceptionType.receiveTimeout:
        return ServerFailure(
          errorMsg: "Receive Timeout..Please check your internet connection.",
        );
      case DioExceptionType.badCertificate:
        return ServerFailure(
          errorMsg: "Bad Certificate..Don't worry it's our fault.",
        );
      case DioExceptionType.badResponse:
      return ServerFailure.fromResponse(dioException.response!.statusCode!, dioException.response!.data,);
      case DioExceptionType.cancel:
      return ServerFailure(
          errorMsg: "Your request was cancelled",
        );
      case DioExceptionType.connectionError:
      return ServerFailure(
          errorMsg: "No Internet Connection, Don't try to fix it..Go for a walk",
        );
      case DioExceptionType.unknown:
      return ServerFailure(
          errorMsg: "Something went wrong, Actually we don't know if it's your fault or ours, But we're always right.",
        );
    }
  }

  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(errorMsg: response["error"]["message"]);
    } else if (statusCode == 404) {
      return ServerFailure(errorMsg: "Your request not found, Please try again later!");
    }else if(statusCode == 500){
       return ServerFailure(
          errorMsg: "Server Error..Don't worry it's our mistake, Go touch the grass until we fix the problem.",
        );
    }else{
       return ServerFailure(
          errorMsg: "Oops! Something went wrong.",
        );
    }
  }
}
