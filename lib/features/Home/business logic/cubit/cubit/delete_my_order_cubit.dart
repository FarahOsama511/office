import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/error_message.dart';
import '../../../../../core/constants/strings.dart';
import '../../../../../main.dart';
import '../../../data/repositiries/my_order_repo.dart';
import 'delete_my_order_state.dart';

class DeleteOrderCubit extends Cubit<DeleteOrderState> {
  final MyOrderRepo deleteOrderRepo;
  DeleteOrderCubit(this.deleteOrderRepo) : super(DeleteOrderInitial());

  Future<void> deleteOrder(orderId) async {
    logger.d(orderId.toString());
    emit(DeleteOrderLoading());
    final result = await deleteOrderRepo.deleteMyOrder(orderId);
    log(result.toString());
    result.fold((error) {
      final message = getErrorMessage(error.type, navigatorKey.currentContext!);
      emit(DeleteOrderError(message));
    }, (_) => emit(DeleteOrderSuccess()));
  }
}
