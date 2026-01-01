import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theming/color_manager.dart';
import '../../../../core/theming/text_style_manager.dart';
import '../../../Home/data/models/orders_model.dart';
import '../../business_logic/get_all_orders_cubit.dart';
import '../../business_logic/get_all_orders_state.dart';
import 'build_details_order.dart';

Widget buildGetAllOrders({
  required String status,
  required GetAllOrdersState state,
  required BuildContext context,
}) {
  if (state is SuccessGetAllOrders) {
    List<OrdersModel> filteredOrders;

    if (status == "جميع الطلبات") {
      filteredOrders = state.allOrders;
    } else if (status == "قيد الانتظار") {
      filteredOrders = context.read<GetAllOrdersCubit>().pendingOrder;
    } else if (status == "قيد التحضير") {
      filteredOrders = context.read<GetAllOrdersCubit>().acceptedOrder;
    } else if (status == "مكتمل") {
      filteredOrders = context.read<GetAllOrdersCubit>().completedOrder;
    } else {
      filteredOrders = [];
    }
    final now = DateTime.now();

    filteredOrders = filteredOrders.where((order) {
      final date = order.createdAt;
      if (date == null) return false;

      return date.year == now.year &&
          date.month == now.month &&
          date.day == now.day;
    }).toList();
    if (filteredOrders.isEmpty) {
      return Center(
        child: Text(
          "لا توجد طلبات في هذه الحالة 👀",
          style: TextStyleManager.font20RegularGrey,
        ),
      );
    }

    return DetailsOrder(status: status, orders: filteredOrders);
  } else if (state is LoadingGetAllOrders) {
    return Center(
      child: CircularProgressIndicator(color: ColorManager.primaryColor),
    );
  } else if (state is ErrorGetAllOrders) {
    return Center(
      child: Text(
        "حدث خطأ أثناء تحميل الطلبات ",
        style: TextStyleManager.font20RegularGrey,
      ),
    );
  } else {
    return Container();
  }
}
