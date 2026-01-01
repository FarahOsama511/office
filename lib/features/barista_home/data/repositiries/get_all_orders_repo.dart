import 'package:dartz/dartz.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/demo_data/orders_demo.dart';
import '../../../../core/helpers/db_helper.dart';
import '../../../../core/networking/api_error_handler.dart';
import '../../../../core/networking/api_result.dart';
import '../../../Home/data/models/orders_model.dart';

class GetAllOrdersRepo {
  GetAllOrdersRepo();

  Future<RepoResult<List<OrdersModel>>> getAllOrders() async {
    try {
      await Future.delayed(Duration(milliseconds: 500));
      final allOrders = OrdersDemoData.getAllOrders();
      await LocalDatabaseHelper.insertAllOrders(allOrders);
      logger.d(allOrders);
      return Right(allOrders);
    } catch (e) {
      var cachedAllOrders = await LocalDatabaseHelper.getAllOrders();
      if (cachedAllOrders.isNotEmpty) {
        return Right(cachedAllOrders);
      }
      logger.d("error is $e");
      return left(ApiErrorHandler.handle(e));
    }
  }

  Future<RepoResult<OrdersModel>> updateOrder(
    String status,
    String orderId,
  ) async {
    try {
      await Future.delayed(Duration(milliseconds: 800));

      final order = OrdersDemoData.updateOrderStatus(orderId, status);
      logger.d("Order status updated: $order");
      return Right(order);
    } catch (e) {
      logger.d("error is $e");
      return left(ApiErrorHandler.handle(e));
    }
  }
}
