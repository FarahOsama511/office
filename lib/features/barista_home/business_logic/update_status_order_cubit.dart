import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/error_message.dart';
import '../../../core/networking/api_error_handler.dart';
import '../../../main.dart';
import '../data/repositiries/get_all_orders_repo.dart';
import 'update_status_order_state.dart';

class UpdateOrderCubit extends Cubit<UpdateOrderState> {
  final GetAllOrdersRepo updateOrderRepo;

  UpdateOrderCubit(this.updateOrderRepo) : super(InitialUpdateOrder());

  Future<void> updateOrder(String status, String orderId) async {
    emit(LoadingUpdateOrder());
    final result = await updateOrderRepo.updateOrder(status, orderId);

    result.fold((error) {
      final apiError = ApiErrorHandler.handle(error);

      final message = getErrorMessage(
        apiError.type,
        navigatorKey.currentContext!,
      );
      emit(ErrorUpdateOrder(message));
    }, (updatedOrder) => emit(SuccessUpdateOrder(updatedOrder)));
  }
}
