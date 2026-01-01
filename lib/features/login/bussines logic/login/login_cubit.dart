import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:office_office/core/constants/error_message.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/networking/api_error_handler.dart';
import '../../../../main.dart';
import '../../data/repositries/login_repo.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.loginRepo) : super(LoginInitial());
  final LoginRepo loginRepo;

  Future<void> login(String userName, String password) async {
    emit(LoadingLoginState());
    final result = await loginRepo.login(
      userName,
      password,
      AppConstants.fcmToken ?? "",
    );

    result.fold((error) {
      final apiError = ApiErrorHandler.handle(error);

      final message = getErrorMessage(
        apiError.type,
        navigatorKey.currentContext!,
      );
      emit(ErrorLoginState(message));
    }, (token) => emit(SuccessLoginState()));
  }
}
