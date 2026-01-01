import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routing/approutes.dart';
import '../../../../core/theming/color_manager.dart';
import '../../../../core/theming/text_style_manager.dart';
import '../../../../generated/l10n.dart';
import '../../business logic/cubit/cubit/log_out_cubit.dart';
import '../../business logic/cubit/cubit/log_out_state.dart';
import '../../business logic/cubit/cubit/my_orders_cubit.dart';
import '../../business logic/cubit/cubit/my_orders_state.dart';
import '../../data/models/orders_model.dart';
import '../widgets/settings_card.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LogOutCubit, LogOutState>(
      listener: (context, state) {
        if (state is SuccessLogOut) {
          context.go(AppRoutes.login);
        } else if (state is ErrorLogOut) {
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
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.r),
              child: Column(
                children: [
                  SizedBox(
                    height: 360,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          height: 200.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                ColorManager.orangeColor,
                                ColorManager.primaryColor,
                              ],
                            ),
                          ),
                        ),

                        SettingsCard(),
                      ],
                    ),
                  ),

                  SizedBox(height: 20.h),
                  BlocBuilder<GetMyOrdersCubit, MyOrdersState>(
                    builder: (context, state) {
                      final allOrders = context
                          .read<GetMyOrdersCubit>()
                          .completedOrder;
                      DateTime oneWeekAgo = DateTime.now().toLocal().subtract(
                        Duration(days: 7),
                      );
                      List<OrdersModel> recentOrders = allOrders
                          .where(
                            (order) => order.createdAt!.isAfter(oneWeekAgo),
                          )
                          .toList();
                      return Container(
                        height: 120.h,
                        width: 300.w,
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(8.r),

                          boxShadow: [
                            BoxShadow(
                              color: ColorManager.orangeColor.withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 2,
                              offset: const Offset(0, 0),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 14.w,
                            vertical: 14.h,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                S.of(context).stats,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              const Spacer(),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        "${allOrders.length}",
                                        textAlign: TextAlign.center,
                                        style: TextStyleManager.font20Bold
                                            .copyWith(
                                              color: ColorManager.orangeColor,
                                            ),
                                      ),
                                      Text(
                                        S.of(context).totalOrders,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                              color: ColorManager.greyColor,
                                            ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "${recentOrders.length}",
                                        textAlign: TextAlign.center,
                                        style: TextStyleManager.font20Bold
                                            .copyWith(
                                              color: ColorManager.primaryColor,
                                            ),
                                      ),
                                      Text(
                                        S.of(context).ThisWeek,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                              color: ColorManager.greyColor,
                                            ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                  SizedBox(height: 65.h),
                  GestureDetector(
                    onTap: () {
                      BlocProvider.of<LogOutCubit>(context).logOut();
                    },
                    child: Container(
                      width: 310.w,
                      height: 45.h,
                      padding: EdgeInsets.symmetric(vertical: 7.h),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.red, width: 2.w),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.logout, color: Colors.red, size: 25),
                          SizedBox(width: 5.w),
                          Text(
                            S.of(context).logOut,
                            style: Theme.of(context).textTheme.titleLarge!
                                .copyWith(color: ColorManager.redColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
