import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:office_office/features/Home/data/models/item_model.dart';
import '../../../../core/routing/approutes.dart';
import '../../../../core/theming/color_manager.dart';
import '../../../../generated/l10n.dart';
import '../../business logic/cubit/cubit/delete_my_order_cubit.dart';
import '../../business logic/cubit/cubit/my_orders_cubit.dart';
import '../../business logic/cubit/cubit/my_orders_state.dart';
import '../../data/models/orders_model.dart';
import 'details_status_order.dart';

Widget buildOrdersByState({
  required String selectedStatus,
  required MyOrdersState state,
  required BuildContext context,
}) {
  if (state is MyOrdersSuccess) {
    List<OrdersModel> filteredOrders = [];
    final now = DateTime.now();

    bool isToday(DateTime? date) {
      if (date == null) return false;
      return date.year == now.year &&
          date.month == now.month &&
          date.day == now.day;
    }

    if (selectedStatus == S.of(context).waiting) {
      filteredOrders = context
          .read<GetMyOrdersCubit>()
          .pendingOrder
          .where((order) => isToday(order.createdAt))
          .toList();
    } else if (selectedStatus == S.of(context).onProgress) {
      filteredOrders = context
          .read<GetMyOrdersCubit>()
          .acceptedOrder
          .where((order) => isToday(order.createdAt))
          .toList();
    } else if (selectedStatus == S.of(context).completed) {
      filteredOrders = context
          .read<GetMyOrdersCubit>()
          .completedOrder
          .where((order) => isToday(order.createdAt))
          .toList();
    } else {
      filteredOrders = [];
    }

    if (filteredOrders.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: const Color.fromARGB(245, 114, 111, 111),
            radius: 30.r,
            child: Icon(
              Icons.coffee_outlined,
              color: ColorManager.whiteColors,
              size: 40,
            ),
          ),
          Text(
            S.of(context).NoData,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      );
    }

    return DetailsStatusOrder(
      myOrders: filteredOrders,
      state: selectedStatus,
      onEdit: (order) {
        context.push(
          AppRoutes.addOrder,
          extra: {"order": order, "isEdit": true},
        );
      },
      onCancel: (orderId) {
        context.read<DeleteOrderCubit>().deleteOrder(orderId);
      },
      backgroundColor: selectedStatus == S.of(context).waiting
          ? Theme.of(context).colorScheme.primary
          : selectedStatus == S.of(context).onProgress
          ? Theme.of(context).colorScheme.secondary
          : Colors.green,
      statusOrder: selectedStatus == S.of(context).waiting
          ? SizedBox()
          : selectedStatus == S.of(context).onProgress
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).preparing,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ],
            )
          : const SizedBox(),
    );
  } else if (state is MyOrdersLoading) {
    return Skeletonizer(
      child: DetailsStatusOrder(
        myOrders: List.generate(
          6,
          (_) => OrdersModel(
            status: "قيد التحضير",
            id: "4",
            orderNotes: "",

            numberOfSugarSpoons: 222,
            item: ItemModel(
              id: "2",
              name: "Orange juice",
              availability: "availability",
              image:
                  "https://images.unsplash.com/photo-1485808191679-5f86510681a2?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
            ),
          ),
        ),
      ),
    );
  } else if (state is MyOrdersError) {
    return Center(
      child: Text(
        S.of(context).ordersLoadError,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  } else {
    return Container();
  }
}
