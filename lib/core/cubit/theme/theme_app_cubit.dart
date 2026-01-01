import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants/strings.dart';
import '../../helpers/sharedpref_helper.dart';
import 'theme_app_state.dart';

enum AppTheme { light, dark }

class ThemeAppCubit extends Cubit<ThemeAppState> {
  ThemeAppCubit() : super(AppInitialState()) {
    _loadTheme();
  }
  AppTheme currentTheme = AppTheme.dark;
  Future<void> selectAppTheme(AppTheme theme) async {
    currentTheme = theme;
    await SharedprefHelper.setData("Theme", currentTheme.name);
    await SharedprefHelper.setBoolData("isDark", AppConstants.isDark);
    emit(AppChangedTheme());
  }

  ThemeMode get getCurrentTheme {
    logger.d("Getting theme for: $currentTheme");
    switch (currentTheme) {
      case AppTheme.light:
        return ThemeMode.light;
      case AppTheme.dark:
        return ThemeMode.dark;
    }
  }

  Future<void> _loadTheme() async {
    final themeName = SharedprefHelper.getData("Theme");
    if (themeName == null || themeName.isEmpty) {
      currentTheme = AppTheme.dark;
      AppConstants.isDark = true;
    } else {
      currentTheme = AppTheme.values.firstWhere(
        (e) => e.name == themeName,
        orElse: () => AppTheme.dark,
      );
      AppConstants.isDark = SharedprefHelper.getBoolData("isDark") ?? true;
      logger.d("Loaded theme from prefs: $themeName");
      logger.d("isDark: $AppConstants.isDark");
    }

    emit(AppChangedTheme());
  }
}
