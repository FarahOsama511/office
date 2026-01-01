import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/error_message.dart';
import '../../../../../main.dart';
import '../../../data/repositiries/my_order_repo.dart';
import 'add_myorder_state.dart';

class AddMyOrderCubit extends Cubit<AddMyOrderState> {
  final MyOrderRepo addMyOrderRepo;
  AddMyOrderCubit(this.addMyOrderRepo) : super(AddMyOrderInitial());

  Future<void> addOrder(
    int numberOfSugarSpoons,
    String notes,
    String itemId,
    String room,
  ) async {
    emit(AddMyOrderLoading());
    final result = await addMyOrderRepo.addMyOrder(
      numberOfSugarSpoons,
      notes,
      itemId,
      room,
    );

    result.fold((error) {
      final message = getErrorMessage(error.type, navigatorKey.currentContext!);
      emit(AddMyOrderError(message));
    }, (order) => emit(AddMyOrderSuccess()));
  }
}
