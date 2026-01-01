import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/constants/strings.dart';
import 'core/cubit/language/app_language_cubit.dart';
import 'core/cubit/theme/theme_app_cubit.dart';
import 'core/cubit/theme/theme_app_state.dart';
import 'core/get_it.dart' as di;
import 'core/routing/route.dart';
import 'core/theming/color_manager.dart';
import 'features/Home/business logic/cubit/cubit/item_cubit.dart';
import 'features/Home/business logic/cubit/cubit/my_orders_cubit.dart';
import 'features/barista_home/business_logic/get_all_orders_cubit.dart';
import 'generated/l10n.dart';

class officeOffice extends StatelessWidget {
  final Locale initialLanguage;
  const officeOffice({super.key, required this.initialLanguage});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => ThemeAppCubit()),
            BlocProvider(create: (context) => di.setUp<GetMyOrdersCubit>()),
            BlocProvider(create: (context) => di.setUp<GetAllOrdersCubit>()),
            BlocProvider(create: (context) => di.setUp<ItemCubit>()),
            BlocProvider(
              create: (context) => AppLanguageCubit(initialLanguage),
            ),
          ],
          child: Builder(
            builder: (context) {
              return BlocBuilder<AppLanguageCubit, Locale>(
                builder: (context, locale) {
                  return BlocBuilder<ThemeAppCubit, ThemeAppState>(
                    builder: (context, state) {
                      logger.d(AppConstants.isDark);
                      return MaterialApp.router(
                        themeMode: context
                            .read<ThemeAppCubit>()
                            .getCurrentTheme,
                        theme: AppConstants.isDark ? darkTheme : lightTheme,
                        debugShowCheckedModeBanner: false,
                        routerConfig: router,
                        locale: locale,
                        localizationsDelegates: [
                          S.delegate,
                          GlobalMaterialLocalizations.delegate,
                          GlobalWidgetsLocalizations.delegate,
                          GlobalCupertinoLocalizations.delegate,
                        ],
                        supportedLocales: S.delegate.supportedLocales,
                      );
                    },
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
