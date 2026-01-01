import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/color_manager.dart';
import '../../../../generated/l10n.dart';
import '../../business logic/cubit/cubit/delete_my_order_cubit.dart';
import '../../business logic/cubit/cubit/delete_my_order_state.dart';
import '../../business logic/cubit/cubit/my_orders_cubit.dart';

import '../widgets/status_order_widget.dart';

class StatusOrderScreen extends StatefulWidget {
  const StatusOrderScreen({super.key});
  @override
  State<StatusOrderScreen> createState() => _StatusOrderState();
}

class _StatusOrderState extends State<StatusOrderScreen> {
  // String? selectedStatus;

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   selectedStatus ??= S.of(context).waiting;
  // }

  // void selectStatus(String status) {
  //   setState(() {
  //     selectedStatus = status;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeleteOrderCubit, DeleteOrderState>(
      listener: (context, state) {
        if (state is DeleteOrderSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              content: Text(
                S.of(context).deleteOrder,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: ColorManager.whiteColors,
                ),
              ),
              behavior: SnackBarBehavior.floating,

              margin: EdgeInsets.only(left: 16, right: 16),
            ),
          );
          context.read<GetMyOrdersCubit>().getAllOrders();
        }
      },
      child: Scaffold(
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
                      S.of(context).orderStatus,
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
                  S.of(context).titleOrderStatus,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Divider(),
                SizedBox(height: 10.h),
                Expanded(child: const StatusOrderWidget()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
