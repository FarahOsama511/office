import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/strings.dart';
import '../../../../generated/l10n.dart';
import '../../data/models/item_model.dart';
import '../../data/models/orders_model.dart';
import '../widgets/details_my_order.dart';

// ignore: must_be_immutable
class AddorEditOrderScreen extends StatefulWidget {
  final ItemModel? item;
  final OrdersModel? order;
  final bool isEdit;

  const AddorEditOrderScreen({
    super.key,
    this.item,
    this.order,
    this.isEdit = false,
  });

  @override
  State<AddorEditOrderScreen> createState() => _AddorEditOrderScreenState();
}

class _AddorEditOrderScreenState extends State<AddorEditOrderScreen> {
  double numberOfSugar = 0;
  @override
  Widget build(BuildContext context) {
    final bool isEdit = widget.isEdit;
    final item = widget.item;
    final order = widget.order;
    final imageUrl = isEdit ? order?.item?.image ?? '' : item?.image ?? '';
    final name = isEdit ? order?.item?.name ?? '' : item?.name ?? '';
    logger.d(isEdit);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        context.pop();
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: Theme.of(context).iconTheme.color,
                      ),
                    ),
                    Text(
                      isEdit ? S.of(context).editOrder : S.of(context).addOrder,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ],
                ),
                Divider(color: Theme.of(context).colorScheme.outline),
                SizedBox(height: 10.h),

                Container(
                  height: 120.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(8.r),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(
                          context,
                        ).colorScheme.primary.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 25.h,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.r),
                          child: SizedBox(
                            height: 120.h,
                            width: 100.w,
                            child: imageUrl.isNotEmpty
                                ? CachedNetworkImage(
                                    imageUrl: imageUrl,
                                    fit: BoxFit.cover,
                                  )
                                : const Icon(
                                    Icons.image_not_supported,
                                    size: 80,
                                  ),
                          ),
                        ),
                        SizedBox(width: 20.w),
                        Expanded(
                          child: Text(
                            name.isNotEmpty ? name : "اسم غير متوفر",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 10.h),

                DetailsMyOrder(
                  itemId: isEdit ? order?.item?.id ?? "" : item?.id ?? "",
                  order: order,
                  isEdit: isEdit,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
