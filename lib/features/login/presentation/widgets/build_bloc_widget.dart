import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/routing/approutes.dart';
import '../../../../core/theming/color_manager.dart';
import '../../bussines logic/login/login_cubit.dart';
import '../../bussines logic/login/login_state.dart';
import 'login_box.dart';

Widget buildBlocWidget() {
  return BlocConsumer<LoginCubit, LoginState>(
    listener: (context, state) {
      if (state is SuccessLoginState) {
        if (AppConstants.role == "employee") {
          GoRouter.of(context).go(AppRoutes.userHome);
        } else if (AppConstants.role == "barista") {
          GoRouter.of(context).go(AppRoutes.baristaHome);
        }
      } else if (state is ErrorLoginState) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: ColorManager.orangeColor,
            content: Text(
              state.error,
              style: Theme.of(
                context,
              ).textTheme.bodySmall!.copyWith(color: ColorManager.whiteColors),
            ),
            behavior: SnackBarBehavior.floating,

            margin: EdgeInsets.only(left: 15, right: 15),
          ),
        );
      }
    },

    builder: (context, state) {
      if (state is LoadingLoginState) {
        return Center(
          child: CircularProgressIndicator(color: ColorManager.primaryColor),
        );
      }
      return LoginBox();
    },
  );
}
