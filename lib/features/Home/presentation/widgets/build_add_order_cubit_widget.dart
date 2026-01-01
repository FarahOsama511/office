import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/get_it.dart' as di;
import '../../../../core/routing/approutes.dart';
import '../../../../core/theming/color_manager.dart';
import '../../../../generated/l10n.dart';
import '../../business logic/cubit/cubit/add_myorder_cubit.dart';
import '../../business logic/cubit/cubit/add_myorder_state.dart';
import '../../business logic/cubit/cubit/edit_myorder_cubit.dart';
import '../../business logic/cubit/cubit/edit_myorder_state.dart';
import '../../business logic/cubit/cubit/my_orders_cubit.dart';

class BuildAddOrderCubitWidget extends StatelessWidget {
  final String itemId;
  final bool isEdit;
  final Widget Function(bool, BuildContext) child;
  const BuildAddOrderCubitWidget({
    super.key,
    required this.itemId,
    required this.child,
    this.isEdit = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isEdit) {
      return BlocProvider(
        create: (providerContext) => di.setUp<EditMyOrderCubit>(),
        child: Builder(
          builder: (providerContext) {
            return BlocConsumer<EditMyOrderCubit, EditMyOrderState>(
              builder: (providerContext, state) {
                return child(state is EditMyOrderLoading, providerContext);
              },
              listener: (providerContext, state) {
                if (state is EditMyOrderError) {
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
                } else if (state is EditMyOrderSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      content: Text(
                        S.of(context).editOrderSuccess,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: ColorManager.whiteColors,
                        ),
                      ),
                      behavior: SnackBarBehavior.floating,

                      margin: EdgeInsets.only(left: 15, right: 15),
                    ),
                  );
                  BlocProvider.of<GetMyOrdersCubit>(
                    providerContext,
                  ).getAllOrders();
                  providerContext.go(AppRoutes.userHome);
                }
              },
            );
          },
        ),
      );
    } else {
      return BlocProvider(
        create: (providerContext) => di.setUp<AddMyOrderCubit>(),
        child: Builder(
          builder: (providerContext) {
            return BlocConsumer<AddMyOrderCubit, AddMyOrderState>(
              builder: (providerContext, state) {
                return child(state is AddMyOrderLoading, providerContext);
              },
              listener: (providerContext, state) {
                if (state is AddMyOrderError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Theme.of(context).colorScheme.primary,
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
                } else if (state is AddMyOrderSuccess) {
                  print("${MediaQuery.of(context).padding.top}");
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: ColorManager.orangeColor,
                      content: Text(
                        S.of(context).addOrderSuccess,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: ColorManager.whiteColors,
                        ),
                      ),
                      behavior: SnackBarBehavior.floating,

                      margin: EdgeInsets.only(left: 16, right: 16),
                    ),
                  );
                  BlocProvider.of<GetMyOrdersCubit>(
                    providerContext,
                  ).getAllOrders();
                  providerContext.go(AppRoutes.userHome);
                }
              },
            );
          },
        ),
      );
    }
  }
}
