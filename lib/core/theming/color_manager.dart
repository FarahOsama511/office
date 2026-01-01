import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ColorManager {
  ColorManager._();
  static const Color primaryColor = Color(0xFFF9B723);
  static const Color secondColor = Color(0xFF000201);
  static const Color orangeColor = Color(0xFFFB7212);
  static const Color whiteColors = Colors.white;
  static const Color redColor = Colors.red;
  static const Color greyColor = Color(0xFF9E9E9E);
  static const Color lightGrey = Color.fromARGB(245, 221, 221, 221);
  static const Color greenColor = Colors.green;
}

class LightThemeColors {
  LightThemeColors._();
  static const Color scaffoldBackground = Color(0XFFF5F5F5);
  static const Color primaryColor = Color(0xFFFB7212);
  static const Color secondaryColor = Color(0xFFF9B723);
  static const Color greyColor = Color(0xFF9E9E9E);
  static const Color completeOrder = Color(0xFF10B981);
  static const Color blackColor = Colors.black;
  static const Color textSecondary = Color(0xFF9E9E9E);
  static const Color lightGrey = Color.fromARGB(245, 221, 221, 221);
}

class DarkThemeColors {
  DarkThemeColors._();
  static const Color scaffoldBackground = Color(0XFF121212);
  static const Color greyColor = Color(0xFF9E9E9E);
  static const Color primaryColor = Color(0xFFFB7212); // orange
  static const Color secondaryColor = Color(0xFFF9B723); // yellow
  static const Color completeOrder = Color(0xFF10B981); // green
  static const Color whiteColor = Colors.white;
  static const Color lightGrey = Color.fromARGB(245, 221, 221, 221);
}

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  iconTheme: IconThemeData(color: DarkThemeColors.whiteColor),
  fontFamily: "Cairo",
  brightness: Brightness.dark,
  scaffoldBackgroundColor: DarkThemeColors.scaffoldBackground,
  primaryColor: DarkThemeColors.primaryColor,
  cardColor: Color(0XFF1E1E1E),
  colorScheme: ColorScheme.dark(
    primary: DarkThemeColors.primaryColor,
    secondary: DarkThemeColors.secondaryColor,
    tertiary: DarkThemeColors.whiteColor,
    outline: DarkThemeColors.lightGrey,
  ),
  textTheme: TextTheme(
    headlineMedium: TextStyle(
      color: DarkThemeColors.whiteColor,
      fontSize: 20.sp,
      fontWeight: FontWeight.bold,
    ),
    titleSmall: TextStyle(
      color: DarkThemeColors.greyColor,
      fontSize: 12.sp,
      fontWeight: FontWeight.bold,
    ),
    titleMedium: TextStyle(
      color: DarkThemeColors.whiteColor,
      fontSize: 15.sp,
      fontWeight: FontWeight.bold,
    ),
    titleLarge: TextStyle(
      color: DarkThemeColors.greyColor,
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
    ),
    bodySmall: TextStyle(
      color: DarkThemeColors.whiteColor,
      fontSize: 15.sp,
      fontWeight: FontWeight.bold,
    ),
    bodyLarge: TextStyle(color: DarkThemeColors.whiteColor),
    bodyMedium: TextStyle(
      color: DarkThemeColors.whiteColor,
      fontSize: 18.sp,
      fontWeight: FontWeight.bold,
    ),
  ),
);
final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  fontFamily: "Cairo",
  iconTheme: IconThemeData(color: LightThemeColors.blackColor),
  brightness: Brightness.light,
  scaffoldBackgroundColor: LightThemeColors.scaffoldBackground,
  cardColor: Color(0XFFFEFEFE),
  primaryColor: LightThemeColors.primaryColor,
  colorScheme: ColorScheme.light(
    primary: LightThemeColors.primaryColor,
    onPrimary: LightThemeColors.scaffoldBackground, //للنصوص والايقونات
    secondary: LightThemeColors.secondaryColor,
    tertiary: LightThemeColors.blackColor,
    outline: LightThemeColors.lightGrey, //للخطوط الفاصله
  ),
  textTheme: TextTheme(
    headlineMedium: TextStyle(
      color: LightThemeColors.blackColor,
      fontSize: 20.sp,
      fontWeight: FontWeight.bold,
    ),
    titleSmall: TextStyle(
      color: LightThemeColors.greyColor,
      fontSize: 12.sp,
      fontWeight: FontWeight.bold,
    ),
    titleMedium: TextStyle(
      color: LightThemeColors.blackColor,
      fontSize: 15.sp,
      fontWeight: FontWeight.bold,
    ),
    titleLarge: TextStyle(
      color: LightThemeColors.greyColor,
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
    ),
    bodySmall: TextStyle(
      color: LightThemeColors.blackColor,
      fontSize: 15.sp,
      fontWeight: FontWeight.bold,
    ),
    bodyMedium: TextStyle(
      color: LightThemeColors.blackColor,
      fontSize: 18.sp,
      fontWeight: FontWeight.bold,
    ),
  ),
);
