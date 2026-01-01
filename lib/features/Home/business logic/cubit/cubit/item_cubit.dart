import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/error_message.dart';
import '../../../../../main.dart';
import '../../../data/repositiries/item_repo.dart';
import 'item_state.dart';

class ItemCubit extends Cubit<ItemState> {
  ItemCubit(this.itemRepo) : super(ItemInitial());
  final ItemRepo itemRepo;
  Future<void> getAllItems() async {
    emit(ItemLoading());
    final result = await itemRepo.getItems();

    result.fold(
      (error) {
        final message = getErrorMessage(
          error.type,
          navigatorKey.currentContext!,
        );

        emit(ItemError(message));
      },
      (items) {
        return emit(ItemSuccess(items));
      },
    );
  }
}
