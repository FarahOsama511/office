import '../../Home/data/models/orders_model.dart';

abstract class GetAllOrdersState {}

class InitialGetAllOrders extends GetAllOrdersState {}

class LoadingGetAllOrders extends GetAllOrdersState {}

class SuccessGetAllOrders extends GetAllOrdersState {
  final List<OrdersModel> allOrders;
  SuccessGetAllOrders(this.allOrders);
}

class ErrorGetAllOrders extends GetAllOrdersState {
  final String error;
  ErrorGetAllOrders(this.error);
}
