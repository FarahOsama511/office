import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:office_office/core/constants/strings.dart';
import '../../../../core/theming/color_manager.dart';
import '../../../../generated/l10n.dart';
import '../../business logic/cubit/cubit/my_orders_cubit.dart';
import '../../business logic/cubit/cubit/my_orders_state.dart';
import 'build_orders_by_status_widget.dart';

class StatusOrderWidget extends StatefulWidget {
  const StatusOrderWidget({super.key});
  @override
  State<StatusOrderWidget> createState() => _StatusOrderWidgetState();
}

class _StatusOrderWidgetState extends State<StatusOrderWidget> {
  String? selectedStatus;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    selectedStatus ??= S.of(context).waiting;
  }

  void selectStatus(String status) {
    setState(() {
      selectedStatus = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppConstants.isDark
                ? Theme.of(context).cardColor
                : ColorManager.lightGrey.withOpacity(.6),
            borderRadius: BorderRadius.circular(8.r),
          ),
          padding: EdgeInsets.symmetric(vertical: 7.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildStatusButton(
                S.of(context).waiting,
                ColorManager.orangeColor,
              ),
              buildStatusButton(
                S.of(context).onProgress,
                ColorManager.primaryColor,
              ),
              buildStatusButton(
                S.of(context).completed,
                ColorManager.greenColor,
              ),
            ],
          ),
        ),
        SizedBox(height: 10.h),
        Expanded(
          child: BlocBuilder<GetMyOrdersCubit, MyOrdersState>(
            builder: (context, state) {
              return buildOrdersByState(
                selectedStatus: selectedStatus!,
                state: state,
                context: context,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildStatusButton(String status, Color color) {
    final bool isSelected = selectedStatus == status;
    return GestureDetector(
      onTap: () => selectStatus(status),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
        decoration: BoxDecoration(
          color: isSelected ? color : Colors.transparent,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Text(status, style: Theme.of(context).textTheme.titleMedium),
      ),
    );
  }
}
