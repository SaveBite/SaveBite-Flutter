import 'package:dio/dio.dart';

abstract class Failure {
  final String errorMessage;

  Failure({required this.errorMessage});
}

class ServerFailure extends Failure {
  ServerFailure({required super.errorMessage});

  factory ServerFailure.fromDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(
            errorMessage: "Connection timeout with api server");
      case DioExceptionType.sendTimeout:
        return ServerFailure(errorMessage: "Send timeout with api server");
      case DioExceptionType.receiveTimeout:
        return ServerFailure(errorMessage: "Receive timeout with api server");
      case DioExceptionType.badCertificate:
        return ServerFailure(errorMessage: "Bad tertificate with api server");
      case DioExceptionType.badResponse:
        return ServerFailure.fromBadResponse(
            e.response!.statusCode!, e.response!.data);
      case DioExceptionType.cancel:
        return ServerFailure(errorMessage: "Request to api Was canceld");
      case DioExceptionType.connectionError:
        return ServerFailure(errorMessage: "No Internet connection");
      case DioExceptionType.unknown:
        return ServerFailure(
            errorMessage: "Opps there is an error ,  try again later");
    }
  }

  factory ServerFailure.fromBadResponse(int statusCode, dynamic body) {
    if (statusCode == 404) {
      return ServerFailure(
          errorMessage: "Your request wan not found, please try later");
    } else if (statusCode == 500) {
      return ServerFailure(
          errorMessage: "There is a problem with server, please try later");
    } else if (statusCode == 401) {
      return ServerFailure(errorMessage: 'password is not correct');
    } else if (statusCode == 422) {
      if (body["message"] == "Validation error") {
        return ServerFailure(errorMessage: body["data"][0]);
      } else if (body["message"] == "Something went wrong.") {
        return ServerFailure(errorMessage: "the selected answer is invalid");
      } else if (body["message"] == "messages.Wrong OTP code or expired") {
        return ServerFailure(errorMessage: "wrong OTP code or expired");
      } else {
        return ServerFailure(errorMessage: 'something went wrong');
      }
    } else {
      return ServerFailure(
          errorMessage: "There was an error, please try agaian");
    }
  }
}
