import 'package:office_office/core/helpers/dio_helper.dart';
import '../../../../core/networking/api_endpoints.dart';

class GetMyOrdersWebservice {
  final DioHelper dioHelper;
  GetMyOrdersWebservice({required this.dioHelper});

  Future<dynamic> getMyOrders() async {
    final response = await dioHelper.getData(url: ApiEndpoints.myOrders);
    return response.data;
  }
}
