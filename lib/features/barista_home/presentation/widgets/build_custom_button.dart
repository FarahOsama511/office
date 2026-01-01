import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/theming/color_manager.dart';
import '../../../../core/theming/text_style_manager.dart';
import '../../../Home/data/models/orders_model.dart';
import '../../business_logic/update_status_order_cubit.dart';

class BuildCustomButton extends StatefulWidget {
  final Widget title;
  final Color color;
  final TextStyle? textStyle;
  final void Function()? onPressed;

  const BuildCustomButton({
    super.key,
    required this.title,
    required this.color,
    this.textStyle,
    this.onPressed,
  });

  @override
  State<BuildCustomButton> createState() => _BuildCustomButtonState();
}

class _BuildCustomButtonState extends State<BuildCustomButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        width: 122.w,
        margin: EdgeInsets.only(top: 10.h),
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),

        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(8.r),
          // border: Border.all(color: ColorManager.lightGrey),
        ),
        child: Center(child: widget.title),
      ),
    );
  }
}

class OrderButtons extends StatefulWidget {
  final OrdersModel order;
  final AudioPlayer player;

  const OrderButtons({super.key, required this.order, required this.player});

  @override
  State<OrderButtons> createState() => _OrderButtonsState();
}

class _OrderButtonsState extends State<OrderButtons> {
  bool isPlayer = false;

  void togglePlayer() async {
    final voiceUrl = widget.order.voiceUrl;
    widget.player.onPlayerComplete.listen((event) {
      setState(() {
        isPlayer = false;
      });
    });

    if (!isPlayer) {
      if (voiceUrl != null && voiceUrl.isNotEmpty) {
        await widget.player.play(UrlSource(voiceUrl));
        setState(() {
          isPlayer = true;
        });
      }
    } else {
      if (voiceUrl != null && voiceUrl.isNotEmpty) {
        await widget.player.pause();
        setState(() {
          isPlayer = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentStatus = StatusOrder.values.firstWhere(
      (e) => e.name == widget.order.status,
      orElse: () => StatusOrder.waiting,
    );
    final nextStatus = AppConstants.statusOrder[currentStatus];

    switch (currentStatus) {
      case StatusOrder.waiting:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BuildCustomButton(
              title: Text(
                "إلغاء الطلب",
                style: TextStyleManager.font14BoldWhite,
              ),
              color: ColorManager.redColor,
              onPressed: () {
                context.read<UpdateOrderCubit>().updateOrder(
                  "cancelled",
                  widget.order.id ?? "0",
                );
              },
            ),
            const SizedBox(width: 10),
            BuildCustomButton(
              title: Text(
                "قبول الطلب",
                style: TextStyleManager.font14BoldWhite,
              ),
              color: ColorManager.greenColor,
              onPressed: () {
                context.read<UpdateOrderCubit>().updateOrder(
                  nextStatus!,
                  widget.order.id ?? "0",
                );
              },
            ),
          ],
        );

      case StatusOrder.onprogress:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BuildCustomButton(
              title: Text(
                "قيد التحضير",
                style: TextStyleManager.font14BoldWhite,
              ),
              color: ColorManager.primaryColor,
              onPressed: () {
                context.read<UpdateOrderCubit>().updateOrder(
                  nextStatus!,
                  widget.order.id ?? "0",
                );
              },
            ),
            const SizedBox(width: 10),
            BuildCustomButton(
              title: Icon(
                isPlayer ? Icons.pause : Icons.play_arrow,
                color: ColorManager.whiteColors,
              ),
              color: ColorManager.orangeColor,
              onPressed: togglePlayer,
            ),
          ],
        );

      case StatusOrder.completed:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BuildCustomButton(
              title: Text("مكتمل", style: TextStyleManager.font14BoldWhite),
              color: ColorManager.greenColor,
              onPressed: null,
            ),
          ],
        );

      default:
        return const SizedBox.shrink();
    }
  }
}
