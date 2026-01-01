import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/error_message.dart';
import '../../../../../main.dart';
import '../../../data/repositiries/my_order_repo.dart';
import 'edit_myorder_state.dart';

class EditMyOrderCubit extends Cubit<EditMyOrderState> {
  final MyOrderRepo myOrderRepo;

  EditMyOrderCubit(this.myOrderRepo) : super(EditMyOrderInitial());

  Future<void> editOrder({
    required String orderId,
    required int numberOfSugarSpoons,
    required String notes,
    required String itemId,
    required String room,
  }) async {
    emit(EditMyOrderLoading());

    final result = await myOrderRepo.editMyOrder(
      orderId,
      numberOfSugarSpoons,
      notes,
      itemId,
      room,
    );

    result.fold((error) {
      final message = getErrorMessage(error.type, navigatorKey.currentContext!);
      emit(EditMyOrderError(message));
    }, (order) => emit(EditMyOrderSuccess(order: order)));
  }
}
