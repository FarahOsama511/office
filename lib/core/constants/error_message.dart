import 'package:flutter/material.dart';
import '../../generated/l10n.dart';

enum ApiErrorType {
  connectionTimeout,
  sendTimeout,
  receiveTimeout,
  badCertificate,
  cancel,
  connectionError,
  badResponse,
  unauthorized,
  notFound,
  timeout,
  serverError,
  networkError,
  userNameError,
  passwordError,
  alreadyExists,
  limitReached,
  requestCancelled,
  unknown,
  invalidData,
}

String getErrorMessage(ApiErrorType type, BuildContext context) {
  switch (type) {
    case ApiErrorType.connectionTimeout:
      return S.of(context).connectionTimeout;
    case ApiErrorType.sendTimeout:
      return S.of(context).sendTimeout;
    case ApiErrorType.receiveTimeout:
      return S.of(context).receiveTimeout;
    case ApiErrorType.badCertificate:
      return S.of(context).badCertificate;
    case ApiErrorType.requestCancelled:
      return S.of(context).requestCancelled;
    case ApiErrorType.networkError:
      return S.of(context).networkError;
    case ApiErrorType.notFound:
      return S.of(context).notFound;
    case ApiErrorType.invalidData:
      return S.of(context).invalidData;
    case ApiErrorType.unauthorized:
      return S.of(context).unauthorized;
    case ApiErrorType.serverError:
      return S.of(context).serverError;
    case ApiErrorType.userNameError:
      return S.of(context).userNameError;
    case ApiErrorType.passwordError:
      return S.of(context).passwordError;
    case ApiErrorType.limitReached:
      return S.of(context).limitReached;

    default:
      return S.of(context).unexpectedError;
  }
}
