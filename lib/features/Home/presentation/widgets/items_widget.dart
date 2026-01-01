import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:office_office/features/Home/presentation/widgets/animated_item.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/routing/approutes.dart';
import '../../../../core/theming/color_manager.dart';
import '../../business logic/cubit/cubit/item_cubit.dart';
import '../../data/models/item_model.dart';

// ignore: must_be_immutable
class ItemsWidget extends StatefulWidget {
  final List<ItemModel> items;

  const ItemsWidget({super.key, this.items = const []});
  @override
  State<ItemsWidget> createState() => _ItemsWidgetState();
}

class _ItemsWidgetState extends State<ItemsWidget> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Theme.of(context).colorScheme.secondary,
      onRefresh: () async {
        await context.read<ItemCubit>().getAllItems();
      },
      child: GridView.builder(
        padding: EdgeInsets.symmetric(vertical: 10.r),
        shrinkWrap: false,
        itemCount: widget.items.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 10.h,
          childAspectRatio: 2 / 2.5,
          crossAxisSpacing: 10,
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) {
          final item = widget.items[index];
          return AnimatedItem(
            index: index,
            child: InkWell(
              onTap: () {
                context.push(
                  AppRoutes.addOrder,
                  extra: {"item": item, "isEdit": false},
                );

                logger.d(item);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).primaryColor.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: const Offset(0, 0),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(8.r),
                  border: AppConstants.isDark
                      ? null
                      : Border.all(color: ColorManager.lightGrey),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),

                      child: Stack(
                        children: [
                          SizedBox(
                            height: 130.h,
                            width: double.infinity,
                            child: CachedNetworkImage(
                              imageUrl: item.image!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            "${item.name}",
                            style: Theme.of(
                              context,
                            ).textTheme.titleMedium!.copyWith(fontSize: 14.sp),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
