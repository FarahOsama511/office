import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/color_manager.dart';
import '../../../../core/theming/text_style_manager.dart';

class BuildWidgetTextField extends StatelessWidget {
  final String hintText;
  final bool? isObscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final int? maxLines;
  BuildWidgetTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.isObscureText,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines ?? 1,
      autocorrect: true,
      style: TextStyleManager.font15RegularBlack,
      controller: controller,
      obscureText: isObscureText ?? false,
      onChanged: onChanged,
      cursorColor: ColorManager.secondColor,
      cursorWidth: 1,
      cursorHeight: 20,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hintText,
        hintStyle: TextStyleManager.font15RegularGrey,
        isDense: true,
        contentPadding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            style: BorderStyle.solid,
            color: ColorManager.orangeColor,
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: ColorManager.lightGrey),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: Colors.red),
        ),

        filled: true,
        fillColor: Color.fromARGB(255, 238, 235, 235),
      ),
      validator: validator ?? (_) => null,
    );
  }
}
