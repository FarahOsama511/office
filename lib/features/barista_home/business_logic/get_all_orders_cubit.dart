import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/error_message.dart';
import '../../../core/constants/strings.dart';
import '../../../core/networking/api_error_handler.dart';
import '../../../main.dart';
import '../../Home/data/models/orders_model.dart';
import '../data/repositiries/get_all_orders_repo.dart';
import 'get_all_orders_state.dart';

class GetAllOrdersCubit extends Cubit<GetAllOrdersState> {
  GetAllOrdersCubit(this.getAllOrdersRepo) : super(InitialGetAllOrders());
  final GetAllOrdersRepo getAllOrdersRepo;
  List<OrdersModel> allOrders = [];
  List<OrdersModel> pendingOrder = [];
  List<OrdersModel> completedOrder = [];
  List<OrdersModel> acceptedOrder = [];
  Future<void> getAllOrders() async {
    emit(LoadingGetAllOrders());
    final result = await getAllOrdersRepo.getAllOrders();
    result.fold(
      (error) {
        final apiError = ApiErrorHandler.handle(error);

        final message = getErrorMessage(
          apiError.type,
          navigatorKey.currentContext!,
        );
        emit(ErrorGetAllOrders(message));
      },
      (items) {
        emit(SuccessGetAllOrders(items));
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
