import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/text_style_manager.dart';
import '../../../../generated/l10n.dart';
import '../widgets/build_bloc_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(14.r, 80.r, 14.r, 14.r),
            child: Column(
              children: [
                Center(
                  child: Container(
                    height: 90.h,
                    width: 100.w,
                    decoration: BoxDecoration(),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: Image.asset(
                        "assets/images/logo-removebg-preview.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20.h),
                Text(
                  S.of(context).officeOffice,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),

                SizedBox(height: 10.h),
                Text(
                  S.of(context).titleLogIn,
                  style: TextStyleManager.font20RegularGrey,
                ),

                SizedBox(height: 20.h),

                buildBlocWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
