abstract class AddMyOrderState {}

final class AddMyOrderInitial extends AddMyOrderState {}

final class AddMyOrderLoading extends AddMyOrderState {}

final class AddMyOrderSuccess extends AddMyOrderState {}

final class AddMyOrderError extends AddMyOrderState {
  final String error;
  AddMyOrderError(this.error);
}
