abstract class LogOutState {}

class InitialLogOut extends LogOutState {}

class LoadingLogOut extends LogOutState {}

class SuccessLogOut extends LogOutState {}

class ErrorLogOut extends LogOutState {
  final String error;
  ErrorLogOut(this.error);
}
