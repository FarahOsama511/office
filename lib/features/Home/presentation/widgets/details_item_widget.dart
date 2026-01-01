import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:office_office/core/constants/strings.dart';
import 'package:office_office/features/Home/presentation/widgets/animated_item.dart';
import '../../../../core/theming/color_manager.dart';
import '../../../../generated/l10n.dart';
import '../../business logic/cubit/cubit/add_myorder_cubit.dart';
import '../../business logic/cubit/cubit/my_orders_cubit.dart';
import '../../data/models/orders_model.dart';
import 'build_add_order_cubit_widget.dart';

class DetailsItemWidget extends StatefulWidget {
  final List<OrdersModel> allOrders;
  const DetailsItemWidget({super.key, this.allOrders = const []});

  @override
  State<DetailsItemWidget> createState() => _DetailsItemWidgetState();
}

class _DetailsItemWidgetState extends State<DetailsItemWidget> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Theme.of(context).colorScheme.secondary,
      onRefresh: () async {
        await context.read<GetMyOrdersCubit>().getAllOrders();
      },
      child: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(height: 10.h),
        itemCount: widget.allOrders.length,
        itemBuilder: (context, index) {
          final order = widget.allOrders[index];
          return AnimatedItem(
            index: index,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
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
                            imageUrl:
                                order.item?.image ??
                                "https://thvnext.bing.com/th/id/OIP.GdL69NaUTPtmqZ3vAPcRyQHaHa?w=185&h=185&c=7&r=0&o=7",
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
                              style: Theme.of(
                                context,
                              ).textTheme.bodySmall!.copyWith(fontSize: 16.sp),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "${DateFormat('yyy/MM/dd').format(order.createdAt ?? DateTime.now())} ",
                              style: Theme.of(context).textTheme.titleMedium!
                                  .copyWith(
                                    color: ColorManager.greyColor,
                                    fontWeight: FontWeight.w400,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 85.w,
                        padding: EdgeInsets.symmetric(vertical: 2.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: ColorManager.greenColor,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          S.of(context).completed,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(
                                fontSize: 14.sp,
                                color: LightThemeColors.scaffoldBackground,
                              ),
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
                        style: Theme.of(
                          context,
                        ).textTheme.titleLarge!.copyWith(fontSize: 14.sp),
                      ),
                      Text(
                        "${order.numberOfSugarSpoons}",
                        style: Theme.of(
                          context,
                        ).textTheme.titleLarge!.copyWith(fontSize: 14.sp),
                      ),
                    ],
                  ),

                  SizedBox(height: 10.h),

                  Divider(
                    endIndent: 10,
                    indent: 10,
                    color: Theme.of(context).colorScheme.outline,
                  ),

                  SizedBox(height: 10.h),
                  BuildAddOrderCubitWidget(
                    itemId: order.item?.id ?? "",
                    child: (_, providerContext) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: InkWell(
                          onTap: () {
                            providerContext.read<AddMyOrderCubit>().addOrder(
                              order.numberOfSugarSpoons ?? 0,
                              order.orderNotes ?? "",
                              order.item?.id ?? "",
                              "101",
                            );
                          },
                          child: Container(
                            height: 30.h,
                            padding: EdgeInsets.symmetric(vertical: 5.h),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,

                              border: AppConstants.isDark
                                  ? null
                                  : Border.all(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.outline,
                                    ),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Text(
                              textAlign: TextAlign.center,
                              S.of(context).reorder,
                              style: Theme.of(context).textTheme.titleMedium!
                                  .copyWith(
                                    color: LightThemeColors.scaffoldBackground,
                                  ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
