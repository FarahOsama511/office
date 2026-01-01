import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:office_office/core/helpers/dio_helper.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/networking/api_endpoints.dart';

class LoginWebservice {
  DioHelper dioHelper = DioHelper();
  Future<dynamic> login(
    String username,
    String password,
    String fcmToken,
  ) async {
    Response response = await dioHelper.postData(
      url: ApiEndpoints.login,
      data: {"username": username, "password": password, "fcm_token": fcmToken},
    );
    log("======================${fcmToken}=============");
    logger.d(response.statusCode);
    return response.data;
  }
}
