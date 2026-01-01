import 'dart:developer';
import 'package:dio/dio.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/helpers/dio_helper.dart';
import '../../../../core/networking/api_endpoints.dart';

class MyOrdersWebservice {
  DioHelper dioHelper = DioHelper();
  Future<dynamic> addMyOrder(
    int numberOfSugarSpoons,
    String notes,
    String itemId,
  ) async {
    Response response = await dioHelper.postData(
      url: ApiEndpoints.orders,
      data: {
        "number_of_sugar_spoons": numberOfSugarSpoons,
        "order_notes": notes,
        "item_id": itemId,
      },
    );

    logger.d(response.statusCode);

    return response.data;
  }

  Future<dynamic> deleteMyOrder(String orderId) async {
    log(orderId.toString());
    Response response = await dioHelper.deleteData(
      url: "${ApiEndpoints.orders}$orderId",
    );
    logger.d(response.statusCode);

    return response.data;
  }

  Future<dynamic> editMyOrder(
    String orderId,
    int numberOfSugarSpoons,
    String orderNotes,
    String itemId,
  ) async {
    logger.d("Saved token: ${AppConstants.savedToken}");
    logger.d("${ApiEndpoints.orders}edit/$orderId");

    Response response = await dioHelper.putData(
      url: "${ApiEndpoints.orders}edit/$orderId",
      data: {
        "number_of_sugar_spoons": numberOfSugarSpoons,
        "order_notes": orderNotes,
        "item_id": itemId,
      },
    );

    logger.d(response.statusCode);

    return response.data;
  }
}
