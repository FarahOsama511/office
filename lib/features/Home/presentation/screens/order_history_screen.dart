import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:office_office/core/constants/strings.dart';
import '../../../../generated/l10n.dart';
import '../../business logic/cubit/cubit/my_orders_cubit.dart';
import '../../business logic/cubit/cubit/my_orders_state.dart';
import '../../data/models/item_model.dart';
import '../../data/models/orders_model.dart';
import '../widgets/details_item_widget.dart';
import '../widgets/filter_widget.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});
  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  List<OrdersModel> filteredOrders = [];
  FilterTime currentFilter = FilterTime.all;

  @override
  void initState() {
    super.initState();

    // Safe context.read inside init
    WidgetsBinding.instance.addPostFrameCallback((_) {
      filteredOrders = context.read<GetMyOrdersCubit>().completedOrder;
      setState(() {});
    });
  }

  List<OrdersModel> filterByTime(FilterTime filter) {
    final completedOrders = context.read<GetMyOrdersCubit>().completedOrder;
    final now = DateTime.now().toLocal();

    switch (filter) {
      case FilterTime.today:
        return completedOrders.where((o) {
          final d = o.createdAt!;
          return d.year == now.year && d.month == now.month && d.day == now.day;
        }).toList();

      case FilterTime.week:
        final start = now.subtract(Duration(days: now.weekday - 1));
        final end = start.add(const Duration(days: 6));

        return completedOrders.where((o) {
          final d = o.createdAt!;
          return d.isAtSameMomentAs(start) ||
              (d.isAfter(start) &&
                  d.isBefore(end.add(const Duration(days: 1))));
        }).toList();

      case FilterTime.month:
        return completedOrders.where((o) {
          final d = o.createdAt!;
          return d.year == now.year && d.month == now.month;
        }).toList();

      case FilterTime.all:
        return completedOrders;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).orderHistory,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  SizedBox(
                    height: 30.h,
                    width: 30.w,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: Image.asset(
                        "assets/images/logo-removebg-preview.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                S.of(context).titleOrderHistory,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 10.h),
              CustomDropdownExample(
                onChanged: (filter) {
                  setState(() {
                    currentFilter = filter!;
                    filteredOrders = filterByTime(currentFilter);
                  });
                },
              ),
              SizedBox(height: 10.h),
              Divider(color: Theme.of(context).colorScheme.outline),
              SizedBox(height: 10.h),
              Expanded(
                child: BlocBuilder<GetMyOrdersCubit, MyOrdersState>(
                  builder: (context, state) {
                    logger.d(filteredOrders.length);
                    if (state is MyOrdersLoading) {
                      return SizedBox(
                        height: 400.h,
                        child: Skeletonizer(
                          containersColor: Theme.of(context).cardColor,
                          child: DetailsItemWidget(
                            allOrders: List.generate(
                              6,
                              (_) => OrdersModel(
                                id: "4",
                                orderNotes: "",

                                numberOfSugarSpoons: 2,
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
                        ),
                      );
                    }
                    if (state is MyOrdersSuccess) {
                      final updatedList = filterByTime(currentFilter);
                      return DetailsItemWidget(allOrders: updatedList);
                    } else if (state is MyOrdersError) {
                      return Center(
                        child: Text(
                          S.of(context).ordersLoadError,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
