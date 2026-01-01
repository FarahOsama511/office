import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:office_office/core/constants/strings.dart';
import '../../../../core/theming/color_manager.dart';
import '../../../../core/theming/text_style_manager.dart';
import '../../business_logic/get_all_orders_cubit.dart';
import '../../business_logic/get_all_orders_state.dart';
import '../widgets/build_get_all_orders_cubit.dart';
import '../widgets/dialog_settings.dart';

class BaristaScreen extends StatefulWidget {
  const BaristaScreen({super.key});
  @override
  State<BaristaScreen> createState() => _BaristaScreenState();
}

class _BaristaScreenState extends State<BaristaScreen> {
  String selectedStatus = "قيد الانتظار";

  void selectStatus(String status) {
    setState(() {
      selectedStatus = status;
    });
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetAllOrdersCubit>(context).getAllOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.r),
            child: BlocConsumer<GetAllOrdersCubit, GetAllOrdersState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 170.h,
                      child: Stack(
                        alignment: Alignment.topRight,
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            height: 150.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(8.r),
                                bottomRight: Radius.circular(8.r),
                              ),
                              gradient: LinearGradient(
                                begin: AlignmentGeometry.centerLeft,
                                end: AlignmentDirectional.topStart,
                                colors: [
                                  const Color.fromARGB(255, 131, 123, 123),
                                  ColorManager.secondColor,
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 40,
                            right: 0,
                            left: 0,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                                vertical: 10.h,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "مرحبًا  👋",
                                          style: TextStyleManager
                                              .font16BoldBlack
                                              .copyWith(
                                                color: ColorManager.whiteColors,
                                              ),
                                        ),
                                        Text(
                                          "قم بإدارة طلبات القهوة الخاصة بك",
                                          style: TextStyleManager
                                              .font15RegularGrey,
                                        ),
                                      ],
                                    ),
                                  ),
                                  //  SizedBox(width: 60.w),
                                  SettingsWidget(),
                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              padding: EdgeInsets.all(16.r),
                              width: 320.w,
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(8.r),
                              ),

                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    buildStatusOrderButton(
                                      "جميع الطلبات",
                                      context
                                          .read<GetAllOrdersCubit>()
                                          .allOrders
                                          .where((order) {
                                            final now = DateTime.now();
                                            final date = order.createdAt;
                                            if (date == null) return false;

                                            return date.year == now.year &&
                                                date.month == now.month &&
                                                date.day == now.day;
                                          })
                                          .toList()
                                          .length,
                                      Colors.deepOrange,
                                    ),
                                    SizedBox(width: 10.w),
                                    buildStatusOrderButton(
                                      "قيد الانتظار",
                                      context
                                          .read<GetAllOrdersCubit>()
                                          .pendingOrder
                                          .where((order) {
                                            final now = DateTime.now();
                                            final date = order.createdAt;
                                            if (date == null) return false;

                                            return date.year == now.year &&
                                                date.month == now.month &&
                                                date.day == now.day;
                                          })
                                          .toList()
                                          .length,
                                      AppConstants.getStatusColor("waiting"),
                                    ),
                                    SizedBox(width: 10.w),
                                    buildStatusOrderButton(
                                      "قيد التحضير",
                                      context
                                          .read<GetAllOrdersCubit>()
                                          .acceptedOrder
                                          .where((order) {
                                            final now = DateTime.now();
                                            final date = order.createdAt;
                                            if (date == null) return false;

                                            return date.year == now.year &&
                                                date.month == now.month &&
                                                date.day == now.day;
                                          })
                                          .toList()
                                          .length,
                                      AppConstants.getStatusColor("onprogress"),
                                    ),
                                    SizedBox(width: 10.w),
                                    buildStatusOrderButton(
                                      "مكتمل",
                                      context
                                          .read<GetAllOrdersCubit>()
                                          .completedOrder
                                          .where((order) {
                                            final now = DateTime.now();
                                            final date = order.createdAt;
                                            if (date == null) return false;

                                            return date.year == now.year &&
                                                date.month == now.month &&
                                                date.day == now.day;
                                          })
                                          .toList()
                                          .length,
                                      AppConstants.getStatusColor("completed"),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 10.h),
                    buildGetAllOrders(
                      status: selectedStatus,
                      state: state,
                      context: context,
                    ),
                  ],
                );
              },
              listener: (context, state) {
                if (state is ErrorGetAllOrders) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: ColorManager.orangeColor,
                      content: Text(
                        state.error,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: ColorManager.whiteColors,
                        ),
                      ),
                      behavior: SnackBarBehavior.floating,

                      margin: EdgeInsets.only(left: 15, right: 15),
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget buildStatusOrderButton(String status, int numOfOrders, Color color) {
    final bool isSelected = selectedStatus == status;
    return GestureDetector(
      onTap: () => selectStatus(status),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: isSelected ? color : null,
          borderRadius: isSelected
              ? BorderRadius.circular(8.r)
              : BorderRadius.circular(0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                status,
                style: TextStyleManager.font15RegularGrey.copyWith(
                  color: isSelected
                      ? ColorManager.whiteColors
                      : ColorManager.greyColor,
                ),
              ),
              SizedBox(width: 6.w),
              Text(
                "${numOfOrders}",
                style: TextStyleManager.font15RegularBlack.copyWith(
                  color: isSelected ? ColorManager.whiteColors : Colors.grey,
                  fontSize: 13.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
