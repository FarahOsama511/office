import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/theming/color_manager.dart';
import '../../../../core/theming/text_style_manager.dart';
import '../../../Home/data/models/orders_model.dart';
import '../../business_logic/get_all_orders_cubit.dart';
import '../../business_logic/update_status_order_cubit.dart';
import '../../business_logic/update_status_order_state.dart';
import 'build_custom_button.dart';

class DetailsOrder extends StatefulWidget {
  final String status;
  final List<OrdersModel> orders;

  const DetailsOrder({super.key, required this.status, required this.orders});

  @override
  State<DetailsOrder> createState() => _DetailsOrderState();
}

class _DetailsOrderState extends State<DetailsOrder> {
  var currentStatus;
  final player = AudioPlayer();
  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView.separated(
          separatorBuilder: (context, index) => SizedBox(height: 10.h),
          itemCount: widget.orders.length,
          itemBuilder: (context, index) {
            final order = widget.orders[index];
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 14.h),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(8.r),
                boxShadow: [
                  BoxShadow(
                    color: ColorManager.greyColor,
                    blurRadius: .5,
                    offset: const Offset(.5, .5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0.w),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.r),
                          child: SizedBox(
                            width: 45.w,
                            height: 45.w,
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
                                order.user?.name ?? "",
                                style: Theme.of(context).textTheme.bodySmall,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              Text(
                                getTimeAgo(order.createdAt!),
                                style: TextStyleManager.font15RegularGrey,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ),
                        BlocListener<UpdateOrderCubit, UpdateOrderState>(
                          listener: (context, state) {
                            if (state is SuccessUpdateOrder) {
                              context.read<GetAllOrdersCubit>().getAllOrders();
                            } else if (state is ErrorUpdateOrder) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: ColorManager.orangeColor,
                                  content: Text(
                                    state.error,
                                    style: TextStyleManager.font14SemiBoldWhite,
                                  ),
                                  behavior: SnackBarBehavior.floating,
                                  margin: EdgeInsets.only(left: 15, right: 15),
                                ),
                              );
                            }
                          },
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                currentStatus = StatusOrder.values.firstWhere(
                                  (e) => e.name == order.status,
                                  orElse: () => StatusOrder.waiting,
                                );
                              });

                              final nextStatus =
                                  AppConstants.statusOrder[currentStatus];

                              if (nextStatus != null) {
                                context.read<UpdateOrderCubit>().updateOrder(
                                  nextStatus,
                                  order.id ?? "1",
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: ColorManager.orangeColor,
                                    content: Text(
                                      "الطلب مكتمل بالفعل",
                                      style:
                                          TextStyleManager.font14SemiBoldWhite,
                                    ),
                                    behavior: SnackBarBehavior.floating,
                                    margin: EdgeInsets.only(
                                      bottom: 600.h,
                                      left: 15,
                                      right: 15,
                                    ),
                                  ),
                                );
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                                vertical: 4.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppConstants.getStatusColor(
                                  order.status,
                                ),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Text(
                                AppConstants.translateStatus(
                                  order.status ?? "",
                                ),
                                style: TextStyleManager.font14BoldWhite,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "اسم المشروب:",
                        style: TextStyleManager.font15RegularGrey,
                      ),
                      Text(
                        order.item?.name ?? "اسم المشروب",
                        style: TextStyleManager.font15RegularGrey,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "ملاعق السكر:",
                        style: TextStyleManager.font15RegularGrey,
                      ),
                      Text(
                        "${order.numberOfSugarSpoons ?? "-"}",
                        style: TextStyleManager.font15RegularGrey,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "رقم الغرفة:",
                        style: TextStyleManager.font15RegularGrey,
                      ),
                      Text(
                        "${order.user?.room?.name ?? ""}",
                        style: TextStyleManager.font15RegularGrey,
                      ),
                    ],
                  ),
                  if (order.orderNotes != null &&
                      order.orderNotes!.isNotEmpty) ...[
                    const Divider(color: ColorManager.lightGrey),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "ملاحظات:",
                          style: TextStyleManager.font15RegularGrey,
                        ),
                        Text(
                          "${order.orderNotes}",
                          style: TextStyleManager.font15RegularGrey,
                        ),
                      ],
                    ),
                  ],
                  OrderButtons(order: order, player: player),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

String getTimeAgo(DateTime dateTime) {
  final now = DateTime.now();
  final difference = now.difference(dateTime);

  if (difference.inMinutes < 60) {
    return "منذ ${difference.inMinutes} دقيقة";
  } else if (difference.inHours < 24) {
    return "منذ ${difference.inHours} ساعة";
  } else {
    return "منذ ${difference.inDays} يوم";
  }
}
