import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/color_manager.dart';
import '../../../../generated/l10n.dart';
import '../../bussines logic/login/login_cubit.dart';
import 'build_widget_text_field.dart';

class LoginBox extends StatefulWidget {
  const LoginBox({super.key});

  @override
  State<LoginBox> createState() => _LoginBoxState();
}

class _LoginBoxState extends State<LoginBox> {
  bool isObscureText = true;
  final formKey = GlobalKey<FormState>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _userNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      height: 250.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 2,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).userName,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 5.h),
              BuildWidgetTextField(
                key: const Key('usernameField'),
                hintText: S.of(context).enterUserName,
                controller: _userNameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return S.of(context).pleaseEnterUserName;
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.h),

              Text(
                S.of(context).password,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 5.h),
              BuildWidgetTextField(
                key: const Key('passwordField'),
                hintText: S.of(context).enterPassword,
                controller: _passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return S.of(context).pleaseEnterPassword;
                  }
                  return null;
                },
                isObscureText: isObscureText,

                suffixIcon: IconButton(
                  key: const Key('loginButton'),
                  onPressed: () {
                    setState(() {
                      isObscureText = !isObscureText;
                    });
                  },
                  icon: Icon(
                    isObscureText ? Icons.visibility_off : Icons.visibility,
                    color: ColorManager.greyColor,
                  ),
                ),
              ),

              SizedBox(height: 20.h),

              InkWell(
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    BlocProvider.of<LoginCubit>(
                      context,
                    ).login(_userNameController.text, _passwordController.text);
                  }
                },
                child: Container(
                  width: double.infinity,
                  height: 40.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: ColorManager.orangeColor,
                  ),
                  child: Text(
                    S.of(context).login,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium!.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
