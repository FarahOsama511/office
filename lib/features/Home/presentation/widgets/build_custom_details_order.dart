import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:office_office/core/theming/text_style_manager.dart';
import '../../../../core/theming/color_manager.dart';
import '../../../../generated/l10n.dart';
import '../../data/models/orders_model.dart';

class BuildCustomDetailsOrder extends StatelessWidget {
  final OrdersModel order;
  BuildCustomDetailsOrder({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

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
      child: Column(
        children: [
          detailsOrder(
            context: context,
            subtitle: "${order.user?.room?.name ?? "SoftWare"}",
            title: S.of(context).room,
            icon: Icons.location_on_outlined,
          ),
          detailsOrder(
            context: context,
            subtitle: "${order.numberOfSugarSpoons ?? 0.toString()}",
            title: S.of(context).spoons,
            icon: Icons.coffee_outlined,
          ),
          Divider(color: ColorManager.lightGrey, endIndent: 10.w, indent: 10.w),
          detailsOrder(
            context: context,
            subtitle: "${order.orderNotes ?? "لا توجد ملاحظات"}",
            title: S.of(context).notes,
            icon: Icons.notes_outlined,
          ),
        ],
      ),
    );
  }

  Widget detailsOrder({
    required String title,
    required String subtitle,
    required IconData icon,
    required BuildContext context,
  }) {
    return ListTile(
      title: Text(
        title,
        style: TextStyleManager.font14SemiBoldWhite.copyWith(
          color: ColorManager.greyColor.withOpacity(1),
        ),
      ),
      subtitle: Text(subtitle, style: Theme.of(context).textTheme.titleMedium),
      trailing: CircleAvatar(
        backgroundColor: const Color.fromARGB(245, 158, 156, 156),
        child: Icon(icon, color: Theme.of(context).iconTheme.color),
      ),
    );
  }
}
