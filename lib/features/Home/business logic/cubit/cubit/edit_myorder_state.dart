import '../../../data/models/orders_model.dart';

abstract class EditMyOrderState {}

final class EditMyOrderInitial extends EditMyOrderState {}

final class EditMyOrderLoading extends EditMyOrderState {}

final class EditMyOrderSuccess extends EditMyOrderState {
  final OrdersModel order;

  EditMyOrderSuccess({required this.order});
}

final class EditMyOrderError extends EditMyOrderState {
  final String error;
  EditMyOrderError(this.error);
}
