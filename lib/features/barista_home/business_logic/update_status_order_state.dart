import '../../Home/data/models/orders_model.dart';

abstract class UpdateOrderState {}

class InitialUpdateOrder extends UpdateOrderState {}

class LoadingUpdateOrder extends UpdateOrderState {}

class SuccessUpdateOrder extends UpdateOrderState {
  final OrdersModel updatedOrder;
  SuccessUpdateOrder(this.updatedOrder);
}

class ErrorUpdateOrder extends UpdateOrderState {
  final String error;
  ErrorUpdateOrder(this.error);
}
