import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'color_manager.dart';

class TextStyleManager {
  TextStyleManager._();
  static TextStyle font24Thin = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 20.sp,
    fontWeight: FontWeight.w100,
    color: ColorManager.secondColor,
  );
  static TextStyle font24Extralight = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 24.sp,
    fontWeight: FontWeight.w200,
    color: ColorManager.secondColor,
  );
  static TextStyle font24Light = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 24.sp,
    fontWeight: FontWeight.w300,
    color: ColorManager.secondColor,
  );
  static TextStyle font20RegularGrey = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 20.sp,
    fontWeight: FontWeight.w400,
    color: ColorManager.greyColor,
  );
  static TextStyle font15RegularGrey = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 15.sp,
    fontWeight: FontWeight.w400,
    color: const Color.fromARGB(255, 121, 119, 119),
  );
  static TextStyle font14Regular = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: Color(0XFF333333),
  );
  static TextStyle font20RegularBlack = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 20.sp,
    fontWeight: FontWeight.w400,
    color: ColorManager.secondColor,
  );
  static TextStyle font15RegularBlack = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 15.sp,
    fontWeight: FontWeight.w400,
    color: ColorManager.secondColor,
  );
  static TextStyle font15MeduimBlack = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 15.sp,
    fontWeight: FontWeight.w500,
    color: ColorManager.secondColor,
  );
  static TextStyle font20Bold = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
    color: ColorManager.secondColor,
  );
  static TextStyle font15Bold = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 15.sp,
    fontWeight: FontWeight.bold,
    color: ColorManager.secondColor,
  );
  static TextStyle font16BoldBlack = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
    color: ColorManager.secondColor,
  );
  static TextStyle font24Bold = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 24.sp,
    fontWeight: FontWeight.bold,
    color: ColorManager.secondColor,
  );
  static TextStyle font20BoldWhite = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
    color: ColorManager.whiteColors,
  );
  static TextStyle font16BoldWhite = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
    color: ColorManager.whiteColors,
  );
  static TextStyle font14BoldWhite = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 14.sp,
    fontWeight: FontWeight.bold,
    color: ColorManager.whiteColors,
  );
  static TextStyle font14SemiBoldWhite = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    color: ColorManager.whiteColors,
  );
}
