import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/color_manager.dart';

class LanguageSwitch extends StatelessWidget {
  final bool isEnglish;
  final Function(bool) onChanged;

  const LanguageSwitch({
    super.key,
    required this.isEnglish,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!isEnglish),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 250),
        width: 60,
        height: 34,
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        decoration: BoxDecoration(
          color: isEnglish
              ? Theme.of(context).colorScheme.primary.withOpacity(.5)
              : ColorManager.lightGrey,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            Positioned(
              right: isEnglish ? null : 0,
              left: isEnglish ? null : 0,
              top: 3,
              child: Text(
                isEnglish ? "EN" : "AR",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            AnimatedAlign(
              duration: Duration(milliseconds: 250),
              alignment: isEnglish
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: Container(
                width: isEnglish ? 25 : 18,
                height: isEnglish ? 25 : 18,
                decoration: BoxDecoration(
                  color: isEnglish
                      ? Theme.of(context).colorScheme.primary
                      : Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
