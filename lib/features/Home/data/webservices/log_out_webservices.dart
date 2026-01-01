import 'package:dio/dio.dart';
import 'package:office_office/core/helpers/dio_helper.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/networking/api_endpoints.dart';

class LogOutWebservices {
  DioHelper dioHelper = DioHelper();
  Future<dynamic> logOut() async {
    Response response = await dioHelper.postData(url: ApiEndpoints.logOut);
    logger.d(response.statusCode);
    return response.data;
  }
}
