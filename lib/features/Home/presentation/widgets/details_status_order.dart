import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:office_office/core/constants/strings.dart';
import 'package:office_office/features/Home/presentation/widgets/animated_item.dart';
import '../../../../core/routing/approutes.dart';
import '../../../../core/theming/text_style_manager.dart';
import '../../../../generated/l10n.dart';
import '../../business logic/cubit/cubit/my_orders_cubit.dart';
import '../../data/models/orders_model.dart';

class DetailsStatusOrder extends StatefulWidget {
  final String state;
  final Color? backgroundColor;
  final Widget? statusOrder;
  final List<OrdersModel> myOrders;
  final Function(String orderId)? onCancel;
  final Function(OrdersModel order)? onEdit;

  DetailsStatusOrder({
    super.key,
    this.onEdit,
    this.onCancel,
    this.state = "",
    this.backgroundColor,
    this.statusOrder,
    this.myOrders = const [],
  });

  @override
  State<DetailsStatusOrder> createState() => _DetailsStatusOrderState();
}

class _DetailsStatusOrderState extends State<DetailsStatusOrder> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Theme.of(context).colorScheme.secondary,
      onRefresh: () async {
        await context.read<GetMyOrdersCubit>().getAllOrders();
      },
      child: ListView.separated(
        padding: EdgeInsets.only(top: 10.h, bottom: 30.h),
        separatorBuilder: (context, index) => SizedBox(height: 10.h),
        itemCount: widget.myOrders.length,
        itemBuilder: (context, index) {
          print(widget.myOrders.length);
          final order = widget.myOrders[index];
          final formattedTime = DateFormat(
            'h:mm a',
          ).format(order.createdAt ?? DateTime.now());

          return AnimatedItem(
            index: index,
            child: GestureDetector(
              onTap: () {
                context.push(AppRoutes.datailsOrder, extra: order);
              },
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: const Offset(0, 0),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(8.r),
                ),
                padding: EdgeInsets.all(16.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.r),
                          child: SizedBox(
                            width: 60.w,
                            height: 60.w,
                            child: CachedNetworkImage(
                              imageUrl: order.item?.image ?? "",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        SizedBox(width: 10.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                order.item?.name ?? "",
                                style: AppConstants.isDark
                                    ? TextStyleManager.font16BoldWhite
                                    : TextStyleManager.font16BoldBlack,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "$formattedTime",
                                style: TextStyleManager.font15RegularGrey,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 25.h,
                          width: 90.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            color: widget.backgroundColor,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            widget.state,
                            style: TextStyleManager.font14BoldWhite,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          S.of(context).sugar,
                          style: TextStyleManager.font15RegularGrey,
                        ),
                        Text(
                          "${order.numberOfSugarSpoons}",
                          style: TextStyleManager.font15RegularGrey,
                        ),
                      ],
                    ),

                    SizedBox(height: 5.h),
                    if (order.status == "waiting")
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              if (widget.onCancel != null) {
                                widget.onCancel!(order.id!);
                              }
                            },
                            child: Container(
                              height: 30.h,
                              padding: EdgeInsets.symmetric(
                                vertical: 5.h,
                                horizontal: 10.w,
                              ),

                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Theme.of(context).colorScheme.primary,
                                  width: 1.5.w,
                                ),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Text(
                                textAlign: TextAlign.center,
                                S.of(context).cancelOrder,
                                style: TextStyleManager.font15Bold.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          InkWell(
                            onTap: () {
                              if (widget.onEdit != null) {
                                widget.onEdit!(order);
                              }
                              context.push(
                                AppRoutes.addOrder,
                                extra: {"order": order, "isEdit": true},
                              );

                              logger.d(order.runtimeType);
                            },
                            child: Container(
                              height: 30.h,
                              padding: EdgeInsets.symmetric(
                                vertical: 5.h,
                                horizontal: 10.w,
                              ),
                              // width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Theme.of(context).colorScheme.primary,
                                  width: 1.5.w,
                                ),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Text(
                                textAlign: TextAlign.center,
                                S.of(context).editOrder,
                                style: TextStyleManager.font15Bold.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: widget.statusOrder,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
