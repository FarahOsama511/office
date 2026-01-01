import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/error_message.dart';
import '../../../../../core/constants/strings.dart';
import '../../../../../main.dart';
import '../../../data/models/orders_model.dart';
import '../../../data/repositiries/get_my_orders_repo.dart';
import 'my_orders_state.dart';

class GetMyOrdersCubit extends Cubit<MyOrdersState> {
  GetMyOrdersCubit(this.getMyOrdersRepo) : super(MyOrdersInitial());
  final GetMyOrdersRepo getMyOrdersRepo;
  List<OrdersModel> allOrders = [];
  List<OrdersModel> pendingOrder = [];
  List<OrdersModel> completedOrder = [];
  List<OrdersModel> acceptedOrder = [];

  Future<void> getAllOrders() async {
    emit(MyOrdersLoading());
    final result = await getMyOrdersRepo.getMyOrders();
    result.fold(
      (error) {
        final message = getErrorMessage(
          error.type,
          navigatorKey.currentContext!,
        );
        emit(MyOrdersError(message));
      },
      (items) {
        emit(MyOrdersSuccess(items));
        allOrders = items;
        pendingOrder = allOrders
            .where((order) => order.status == "waiting")
            .toList();
        completedOrder = allOrders
            .where((order) => order.status == "completed")
            .toList();
        acceptedOrder = allOrders
            .where((order) => order.status == "onprogress")
            .toList();

        logger.d(allOrders);
      },
    );
  }
}
