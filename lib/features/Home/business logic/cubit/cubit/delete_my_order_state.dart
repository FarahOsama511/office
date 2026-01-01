abstract class DeleteOrderState {}

final class DeleteOrderInitial extends DeleteOrderState {}

final class DeleteOrderLoading extends DeleteOrderState {}

final class DeleteOrderSuccess extends DeleteOrderState {}

final class DeleteOrderError extends DeleteOrderState {
  final String error;
  DeleteOrderError(this.error);
}
