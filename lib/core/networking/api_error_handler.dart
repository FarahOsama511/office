import 'package:dio/dio.dart';
import '../constants/error_message.dart';
import 'api_error_model.dart';

class ApiErrorHandler {
  static ApiErrorModel handle(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return ApiErrorModel(
            type: ApiErrorType.connectionTimeout,
            statusCode: 408,
          );

        case DioExceptionType.sendTimeout:
          return ApiErrorModel(type: ApiErrorType.sendTimeout, statusCode: 408);

        case DioExceptionType.receiveTimeout:
          return ApiErrorModel(
            type: ApiErrorType.receiveTimeout,
            statusCode: 504,
          );

        case DioExceptionType.badCertificate:
          return ApiErrorModel(
            type: ApiErrorType.badCertificate,
            statusCode: 495,
          );

        case DioExceptionType.cancel:
          return ApiErrorModel(type: ApiErrorType.cancel, statusCode: 499);

        case DioExceptionType.connectionError:
          return ApiErrorModel(
            type: ApiErrorType.connectionError,
            statusCode: 0,
          );

        case DioExceptionType.badResponse:
          final response = error.response;
          if (response != null) {
            final statusCode = response.statusCode ?? 500;
            final mappedType = _translateMessage(response.data);

            return ApiErrorModel(type: mappedType, statusCode: statusCode);
          } else {
            return ApiErrorModel(
              type: ApiErrorType.badResponse,
              statusCode: 500,
            );
          }

        case DioExceptionType.unknown:
          return ApiErrorModel(type: ApiErrorType.unknown, statusCode: 500);
      }
    } else {
      return ApiErrorModel(type: ApiErrorType.unknown, statusCode: 500);
    }
  }

  static ApiErrorType _translateMessage(dynamic message) {
    if (message is Map && message['message'] != null) {
      message = message['message'];
    }

    if (message is! String) return ApiErrorType.unknown;

    final lower = message.toLowerCase();

    if (lower.contains("invalid") || lower.contains("wrong")) {
      return ApiErrorType.invalidData;
    } else if (lower.contains("unauthorized") ||
        lower.contains("forbidden") ||
        lower.contains("token")) {
      return ApiErrorType.unauthorized;
    } else if (lower.contains("not found")) {
      return ApiErrorType.notFound;
    } else if (lower.contains("timeout")) {
      return ApiErrorType.timeout;
    } else if (lower.contains("server") || lower.contains("internal")) {
      return ApiErrorType.serverError;
    } else if (lower.contains("network")) {
      return ApiErrorType.networkError;
    } else if (lower.contains("username")) {
      return ApiErrorType.userNameError;
    } else if (lower.contains("password")) {
      return ApiErrorType.passwordError;
    } else if (lower.contains("exists")) {
      return ApiErrorType.alreadyExists;
    } else if (lower.contains("limit")) {
      return ApiErrorType.limitReached;
    }
    return ApiErrorType.unknown;
  }
}
