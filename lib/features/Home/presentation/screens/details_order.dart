import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:office_office/core/constants/strings.dart';
import 'package:office_office/features/Home/business%20logic/cubit/cubit/my_orders_cubit.dart';
import 'package:office_office/features/Home/business%20logic/cubit/cubit/my_orders_state.dart';
import 'package:office_office/features/Home/presentation/widgets/build_custom_details_order.dart';
import '../../../../core/theming/color_manager.dart';
import '../../../../core/theming/text_style_manager.dart';
import '../../../../generated/l10n.dart';
import '../../data/models/orders_model.dart';
import '../widgets/order_time_line.dart';

class DetailsOrder extends StatefulWidget {
  final OrdersModel order;
  const DetailsOrder({super.key, required this.order});

  @override
  State<DetailsOrder> createState() => _DetailsOrderState();
}

class _DetailsOrderState extends State<DetailsOrder> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetMyOrdersCubit>(context).getAllOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 100.h,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8.r),
                            bottomRight: Radius.circular(8.r),
                          ),

                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Theme.of(context).colorScheme.primary,
                              Theme.of(context).colorScheme.secondary,
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 40.h,
                        child: Padding(
                          padding: EdgeInsets.only(right: 8.w),
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  context.pop();
                                },
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: ColorManager.whiteColors,
                                ),
                              ),
                              Text(
                                S.of(context).detialsOrder,
                                style: TextStyleManager.font20Bold.copyWith(
                                  color: ColorManager.whiteColors,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 10.h),
                BlocBuilder<GetMyOrdersCubit, MyOrdersState>(
                  builder: (context, state) {
                    OrdersModel currentOrder = widget.order;

                    if (state is MyOrdersSuccess) {
                      final matchedOrder = state.orders.firstWhere(
                        (o) => o.id == widget.order.id,
                        orElse: () => widget.order,
                      );
                      currentOrder = widget.order.copyWith(
                        status: matchedOrder.status,
                        voiceUrl: matchedOrder.voiceUrl,
                        item: matchedOrder.item,
                      );
                    }

                    return Column(
                      children: [
                        Container(
                          //margin: EdgeInsets.symmetric(horizontal: 18.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            color: Theme.of(context).cardColor,
                            boxShadow: [
                              BoxShadow(
                                color: ColorManager.orangeColor.withOpacity(
                                  0.2,
                                ),
                                spreadRadius: 2,
                                blurRadius: 2,
                                offset: const Offset(0, 0),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 150.h,
                                width: 150.w,
                                child: CachedNetworkImage(
                                  imageUrl: currentOrder.item?.image ?? "",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(height: 10.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      currentOrder.item?.name ?? "",
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyMedium!,
                                    ),
                                    Container(
                                      height: 25.h,
                                      width: 80.w,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          8.r,
                                        ),
                                        color: AppConstants.getStatusColor(
                                          currentOrder.status,
                                        ),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        currentOrder.status ?? "",
                                        style: TextStyleManager
                                            .font14SemiBoldWhite,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20.h),
                            ],
                          ),
                        ),

                        SizedBox(height: 10.h),

                        OrderStepper(status: currentOrder.status ?? ""),
                      ],
                    );
                  },
                ),

                SizedBox(height: 10.h),
                BuildCustomDetailsOrder(order: widget.order),
                SizedBox(height: 10.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
