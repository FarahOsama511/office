import 'package:dartz/dartz.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/demo_data/orders_demo.dart';
import '../../../../core/helpers/db_helper.dart';
import '../../../../core/networking/api_error_handler.dart';
import '../../../../core/networking/api_result.dart';
import '../models/orders_model.dart';

class GetMyOrdersRepo {
  GetMyOrdersRepo();

  Future<RepoResult<List<OrdersModel>>> getMyOrders() async {
    try {
      final myOrders = OrdersDemoData.getMyOrders();
      await LocalDatabaseHelper.insertMyOrders(myOrders);
      logger.d(myOrders);
      return Right(myOrders);
    } catch (e) {
      var cachedMyOrders = await LocalDatabaseHelper.getMyOrders();
      if (cachedMyOrders.isNotEmpty) {
        logger.d(cachedMyOrders);
        return Right(cachedMyOrders);
      }
      logger.d("error is $e");
      return left(ApiErrorHandler.handle(e));
    }
  }
}
