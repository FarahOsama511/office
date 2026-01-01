import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../generated/l10n.dart';
import 'package:office_office/core/theming/color_manager.dart';
import '../../../../core/constants/strings.dart';

class CustomDropdownExample extends StatefulWidget {
  final void Function(FilterTime?)? onChanged;
  const CustomDropdownExample({super.key, required this.onChanged});

  @override
  State<CustomDropdownExample> createState() => _CustomDropdownExampleState();
}

class _CustomDropdownExampleState extends State<CustomDropdownExample> {
  FilterTime? selectedValue;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    selectedValue = FilterTime.all;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField<FilterTime>(
          iconEnabledColor: AppConstants.isDark
              ? ColorManager.whiteColors
              : ColorManager.secondColor,

          style: Theme.of(context).textTheme.titleMedium,
          value: selectedValue,
          dropdownColor: Theme.of(context).cardColor,

          decoration: InputDecoration(
            filled: true,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 8.h,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(
                color: AppConstants.isDark
                    ? const Color(0XFF2C2C2C)
                    : ColorManager.whiteColors,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(
                color: AppConstants.isDark
                    ? const Color(0XFF2C2C2C)
                    : ColorManager.secondColor,
              ),
            ),
          ),

          items: [
            DropdownMenuItem(
              value: FilterTime.all,
              child: Text(S.of(context).allTime),
            ),
            DropdownMenuItem(
              value: FilterTime.today,
              child: Text(S.of(context).today),
            ),
            DropdownMenuItem(
              value: FilterTime.week,
              child: Text(S.of(context).ThisWeek),
            ),
            DropdownMenuItem(
              value: FilterTime.month,
              child: Text(S.of(context).month),
            ),
          ],

          onChanged: (value) {
            setState(() => selectedValue = value);
            widget.onChanged?.call(value);
          },
        ),
      ),
    );
  }
}
