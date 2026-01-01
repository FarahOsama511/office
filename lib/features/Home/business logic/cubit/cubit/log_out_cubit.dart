import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/error_message.dart';
import '../../../../../core/constants/strings.dart';
import '../../../../../main.dart';
import '../../../data/repositiries/log_out_repo.dart';
import 'log_out_state.dart';

class LogOutCubit extends Cubit<LogOutState> {
  LogOutCubit(this.logOutRepo) : super(InitialLogOut());
  final LogOutRepo logOutRepo;

  Future<void> logOut() async {
    emit(LoadingLogOut());
    final result = await logOutRepo.logOut();
    logger.d(result.toString());
    result.fold((error) {
      final message = getErrorMessage(error.type, navigatorKey.currentContext!);
      emit(ErrorLogOut(message));
    }, (_) => emit(SuccessLogOut()));
  }
}
