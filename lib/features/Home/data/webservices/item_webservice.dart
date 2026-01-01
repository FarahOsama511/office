import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:office_office/core/helpers/dio_helper.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/networking/api_endpoints.dart';

class ItemWebservice {
  DioHelper dioHelper = DioHelper();
  Future<dynamic> getItems() async {
    log("web");
    Response response = await dioHelper.getData(url: ApiEndpoints.items);
    logger.d(response.statusCode);
    return response.data;
  }
}
