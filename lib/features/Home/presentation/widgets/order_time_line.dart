import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:office_office/core/constants/strings.dart';
import 'package:office_office/features/Home/business%20logic/cubit/cubit/my_orders_cubit.dart';
import 'package:office_office/features/Home/business%20logic/cubit/cubit/my_orders_state.dart';
import '../../../../core/theming/color_manager.dart';
import '../../../../core/theming/text_style_manager.dart';
import '../../../../generated/l10n.dart';

class OrderStepper extends StatefulWidget {
  final String status;

  const OrderStepper({super.key, required this.status});

  @override
  State<OrderStepper> createState() => _OrderStepperState();
}

class _OrderStepperState extends State<OrderStepper> {
  int getCurrentStep() {
    switch (widget.status) {
      case 'waiting':
        return 0;
      case 'onprogress':
        return 1;
      case 'completed':
        return 2;
      default:
        return 0;
    }
  }

  Color getColorForStep(int step) {
    switch (step) {
      case 0:
        return ColorManager.orangeColor;
      case 1:
        return ColorManager.primaryColor;
      case 2:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: ColorManager.orangeColor.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 2,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(8.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).orderStatus,
              style: AppConstants.isDark
                  ? TextStyleManager.font14BoldWhite
                  : TextStyleManager.font15Bold,
            ),
            SizedBox(height: 10.h),
            BlocBuilder<GetMyOrdersCubit, MyOrdersState>(
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildStep(context, 0, S.of(context).waiting),
                    _buildLine(context, 0),
                    _buildStep(context, 1, S.of(context).onProgress),
                    _buildLine(context, 1),
                    _buildStep(context, 2, S.of(context).completed),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep(BuildContext context, int step, String title) {
    final currentStep = getCurrentStep();
    final isCompleted = step < currentStep;
    final isCurrent = step == currentStep;

    Color circleColor;
    Color textColor;

    if (isCompleted) {
      circleColor = getColorForStep(step);
      textColor = getColorForStep(step);
    } else if (isCurrent) {
      circleColor = getColorForStep(step);
      textColor = getColorForStep(step);
    } else {
      circleColor = Colors.grey[300]!;
      textColor = Colors.grey[300]!;
    }

    return Column(
      children: [
        Container(
          width: 28.w,
          height: 28.w,
          decoration: BoxDecoration(color: circleColor, shape: BoxShape.circle),
          alignment: Alignment.center,
          child: Text(
            '${step + 1}',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          title,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
            fontSize: 13.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildLine(BuildContext context, int step) {
    final isActive = getCurrentStep() > step;
    return Expanded(
      child: Container(
        height: 3.h,
        color: isActive ? getColorForStep(step) : Colors.grey[300],
      ),
    );
  }
}
