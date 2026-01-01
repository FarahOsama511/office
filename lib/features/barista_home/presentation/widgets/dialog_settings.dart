import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:office_office/features/Home/business%20logic/cubit/cubit/log_out_cubit.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/cubit/theme/theme_app_cubit.dart';
import '../../../../core/routing/approutes.dart';
import '../../../../core/theming/color_manager.dart';
import '../../../../core/theming/text_style_manager.dart';
import '../../../Home/business logic/cubit/cubit/log_out_state.dart';

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({super.key});
  @override
  State<SettingsWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LogOutCubit, LogOutState>(
      listener: (context, state) {
        if (state is SuccessLogOut) {
          context.go(AppRoutes.login);
        }
        if (state is ErrorLogOut) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: ColorManager.orangeColor,
              content: Text(
                state.error,
                style: TextStyleManager.font14SemiBoldWhite,
              ),
              behavior: SnackBarBehavior.floating,

              margin: EdgeInsets.only(left: 15, right: 15),
            ),
          );
        }
      },
      child: IconButton(
        onPressed: () => showSettingsDialog(context),
        icon: Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()..scale(-1.0, 1.0),
          child: Icon(Icons.settings, color: Colors.white),
        ),
      ),
    );
  }

  showSettingsDialog(BuildContext parentContext) {
    return showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).cardColor,
          title: Text(
            "الإعدادات",
            style: Theme.of(context).textTheme.bodySmall,
          ),
          actions: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // Icon(
                    //   isDark ? Icons.dark_mode : Icons.sunny,
                    //   size: 35,
                    //   color: ColorManager.secondColor,
                    // ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppConstants.isDark
                              ? "الوضع الليلي"
                              : "الوضع النهاري",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                    const Spacer(),
                    Switch(
                      inactiveThumbColor: ColorManager.whiteColors,
                      activeThumbColor: ColorManager.orangeColor,
                      inactiveTrackColor: ColorManager.lightGrey,
                      value: AppConstants.isDark,
                      onChanged: (value) {
                        setState(() {
                          AppConstants.isDark = value;
                        });
                        final newTheme = AppConstants.isDark
                            ? AppTheme.dark
                            : AppTheme.light;
                        parentContext.read<ThemeAppCubit>().selectAppTheme(
                          newTheme,
                        );
                      },
                    ),
                  ],
                ),
                const Divider(color: ColorManager.lightGrey),
                GestureDetector(
                  onTap: () => parentContext.read<LogOutCubit>().logOut(),
                  child: Row(
                    children: [
                      Text(
                        "تسجيل الخروج",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const Spacer(),
                      Expanded(
                        child: IconButton(
                          onPressed: () {
                            parentContext.read<LogOutCubit>().logOut();
                          },

                          icon: Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.identity()..scale(-1.0, 1.0),
                            child: Icon(
                              Icons.logout,
                              size: 30,
                              color: AppConstants.isDark
                                  ? ColorManager.whiteColors
                                  : ColorManager.secondColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
