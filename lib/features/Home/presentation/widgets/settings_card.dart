import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:office_office/features/Home/presentation/widgets/language_switch.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/cubit/language/app_language_constant.dart';
import '../../../../core/cubit/language/app_language_cubit.dart';
import '../../../../core/cubit/theme/theme_app_cubit.dart';
import '../../../../core/theming/color_manager.dart';
import '../../../../generated/l10n.dart';

class SettingsCard extends StatefulWidget {
  const SettingsCard({super.key});
  @override
  State<SettingsCard> createState() => _SettingsCardState();
}

class _SettingsCardState extends State<SettingsCard> {
  @override
  void initState() {
    super.initState();
    final currentTheme = context.read<ThemeAppCubit>().currentTheme;
    AppConstants.isDark = currentTheme == AppTheme.dark;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 120.h,
      right: 20.w,
      left: 20.w,
      child: Container(
        height: 160.h,
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 2,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  AppConstants.isDark ? Icons.dark_mode : Icons.light_mode,
                  size: 25,
                  color: Theme.of(context).iconTheme.color,
                ),
                SizedBox(width: 10.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppConstants.isDark
                          ? S.of(context).darkMode
                          : S.of(context).lightMode,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      AppConstants.isDark
                          ? S.of(context).enabled
                          : S.of(context).disabled,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
                const Spacer(),
                Transform.scale(
                  scale: .9,
                  child: Switch(
                    inactiveThumbColor: ColorManager.whiteColors,
                    activeThumbColor: Theme.of(context).colorScheme.primary,
                    inactiveTrackColor: ColorManager.lightGrey,
                    value: AppConstants.isDark,
                    onChanged: (value) {
                      setState(() {
                        AppConstants.isDark = value;
                      });
                      final newTheme = AppConstants.isDark
                          ? AppTheme.dark
                          : AppTheme.light;
                      context.read<ThemeAppCubit>().selectAppTheme(newTheme);
                    },
                  ),
                ),
              ],
            ),
            Divider(color: Theme.of(context).colorScheme.outline),
            Row(
              children: [
                Icon(
                  Icons.lock,
                  size: 25,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).changePassword,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text(
                        S.of(context).updatePassword,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Divider(color: Theme.of(context).colorScheme.outline),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    final currentLanguage = context
                        .read<AppLanguageCubit>()
                        .state;
                    final newLanguage =
                        currentLanguage ==
                            AppLanguageConstant.getArabicLanguage()
                        ? AppLanguageConstant.getEnglishLanguage()
                        : AppLanguageConstant.getArabicLanguage();
                    context.read<AppLanguageCubit>().setLanguage(newLanguage);
                  },
                  child: Icon(Icons.language),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "language",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text(
                        context.read<AppLanguageCubit>().state ==
                                AppLanguageConstant.getArabicLanguage()
                            ? S.of(context).arLanguage
                            : S.of(context).enLanguage,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Transform.scale(
                  scale: .9,
                  child: LanguageSwitch(
                    isEnglish:
                        context.read<AppLanguageCubit>().state ==
                        AppLanguageConstant.getEnglishLanguage(),
                    onChanged: (value) {
                      final newLanguage = value
                          ? AppLanguageConstant.getEnglishLanguage()
                          : AppLanguageConstant.getArabicLanguage();

                      context.read<AppLanguageCubit>().setLanguage(newLanguage);
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
