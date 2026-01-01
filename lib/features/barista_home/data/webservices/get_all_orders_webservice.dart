import 'package:dio/dio.dart';
import 'package:office_office/core/helpers/dio_helper.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/networking/api_endpoints.dart';

class GetAllOrdersWebservice {
  DioHelper dioHelper = DioHelper();

  Future<dynamic> getAllOrders() async {
    Response response = await dioHelper.getData(url: ApiEndpoints.orders);
    logger.d(response.statusCode);
    return response.data;
  }

  Future<dynamic> updateOrder(String status, String orderId) async {
    Response response = await dioHelper.putData(
      url: "${ApiEndpoints.changeStatusOrder}$orderId",

      data: {"status": status},
    );
    logger.d("response: $response");
    logger.d(response.statusCode);
    return response.data;
  }
}
