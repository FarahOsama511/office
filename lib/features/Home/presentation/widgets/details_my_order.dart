import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/color_manager.dart';
import '../../../../generated/l10n.dart';
import '../../../login/presentation/widgets/build_widget_text_field.dart';
import '../../business logic/cubit/cubit/add_myorder_cubit.dart';
import '../../business logic/cubit/cubit/edit_myorder_cubit.dart';
import '../../data/models/orders_model.dart';
import 'build_add_order_cubit_widget.dart';

class DetailsMyOrder extends StatefulWidget {
  final String itemId;
  final OrdersModel? order;
  final bool isEdit;
  const DetailsMyOrder({
    super.key,
    required this.itemId,
    this.order,
    this.isEdit = false,
  });

  @override
  State<DetailsMyOrder> createState() => _DetailsMyOrderState();
}

class _DetailsMyOrderState extends State<DetailsMyOrder> {
  double currentValue = 0;
  final TextEditingController notesController = TextEditingController();
  bool isButtonActive = false;

  @override
  void initState() {
    super.initState();
    if (widget.isEdit && widget.order != null) {
      currentValue = widget.order!.numberOfSugarSpoons?.toDouble() ?? 0;
      notesController.text = widget.order!.orderNotes ?? "";
    }
  }

  @override
  void dispose() {
    super.dispose();
    notesController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.isEdit;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              S.of(context).sugarLevel,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              "${currentValue.toStringAsFixed(0)} ${S.of(context).spoons}",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 20,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
            overlayShape: RoundSliderOverlayShape(overlayRadius: 15),
          ),
          child: Container(
            width: 700.w,
            child: Slider(
              min: 0,
              max: 5,
              activeColor: Theme.of(context).colorScheme.primary,
              inactiveColor: ColorManager.lightGrey,
              thumbColor: ColorManager.whiteColors,
              value: currentValue,
              onChanged: (value) {
                setState(() {
                  currentValue = value;
                });
              },
            ),
          ),
        ),
        SizedBox(height: 10.h),
        Text(S.of(context).notes, style: Theme.of(context).textTheme.bodySmall),
        SizedBox(height: 8.h),
        BuildWidgetTextField(
          hintText: S.of(context).specialRequest,
          controller: notesController,
          maxLines: 3,
        ),
        SizedBox(height: 30.h),

        BuildAddOrderCubitWidget(
          itemId: widget.itemId,
          isEdit: isEdit,
          child: (bool isLoading, providerContext) {
            return addOrEditButton(isLoading, providerContext, isEdit);
          },
        ),
      ],
    );
  }

  Widget addOrEditButton(bool isLoading, BuildContext context, bool isEdit) {
    return InkWell(
      onTap: () {
        if (isEdit && widget.order != null) {
          log(widget.itemId.toString());
          context.read<EditMyOrderCubit>().editOrder(
            orderId: widget.order!.id!,

            numberOfSugarSpoons: int.parse(currentValue.toStringAsFixed(0)),
            room: "101",
            notes: notesController.text,
            itemId: widget.itemId.toString(),
          );
        } else {
          context.read<AddMyOrderCubit>().addOrder(
            currentValue.toInt(),
            notesController.text,
            widget.itemId,
            "101",
          );
        }
      },

      child: Container(
        width: double.infinity,
        height: 40.h,
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,

            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.secondary,
            ],
          ),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Center(
          child: isLoading
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 15,
                      width: 15,
                      child: const CircularProgressIndicator(
                        color: ColorManager.whiteColors,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      isEdit
                          ? S.of(context).updatingOrder
                          : S.of(context).processingOrder,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: LightThemeColors.scaffoldBackground,
                      ),
                    ),
                  ],
                )
              : Text(
                  isEdit ? S.of(context).updateOrder : S.of(context).sendOrder,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: LightThemeColors.scaffoldBackground,
                  ),
                ),
        ),
      ),
    );
  }
}
