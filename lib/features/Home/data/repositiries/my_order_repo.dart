import 'package:dartz/dartz.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/demo_data/orders_demo.dart';
import '../../../../core/networking/api_error_handler.dart';
import '../../../../core/networking/api_result.dart';
import '../models/orders_model.dart';

class MyOrderRepo {
  MyOrderRepo();

  Future<RepoResult<OrdersModel>> addMyOrder(
    int numberOfSugarSpoons,
    String room,
    String notes,
    String itemId,
  ) async {
    try {
      final order = OrdersDemoData.addOrder(
        numberOfSugarSpoons: numberOfSugarSpoons,
        room: room,
        notes: notes,
        itemId: itemId,
        orderId: (OrdersDemoData.getAllOrders().length + 1).toString(),
      );

      logger.d("Order added: $order");
      return Right(order);
    } catch (e) {
      logger.d("error is $e");
      return left(ApiErrorHandler.handle(e));
    }
  }

  Future<RepoResult<void>> deleteMyOrder(String orderId) async {
    logger.d(orderId.toString());
    try {
      OrdersDemoData.deleteOrder(orderId);
      logger.d("Order deleted: $orderId");
      return Right(orderId);
    } catch (e) {
      logger.d("error is $e");
      return left(ApiErrorHandler.handle(e));
    }
  }

  Future<RepoResult<OrdersModel>> editMyOrder(
    String orderId,
    int numberOfSugarSpoons,
    String room,
    String orderNotes,
    String itemId,
  ) async {
    try {
      final order = OrdersDemoData.editOrder(
        orderId: orderId,
        numberOfSugarSpoons: numberOfSugarSpoons,
        room: room,
        notes: orderNotes,
        itemId: itemId,
      );

      logger.d("Order edited: $order");
      return Right(order);
    } catch (e) {
      logger.d("error is $e");
      return left(ApiErrorHandler.handle(e));
    }
  }
}
