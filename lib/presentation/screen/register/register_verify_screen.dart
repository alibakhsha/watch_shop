import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:watch_shop/constant/app_color.dart';
import 'package:watch_shop/constant/app_text_style.dart';
import 'package:watch_shop/presentation/widgets/custom_button.dart';
import 'package:watch_shop/presentation/widgets/text_fields.dart';
import 'package:watch_shop/services/api_sevice.dart';

import '../../../gen/assets.gen.dart';
import '../../../logic/bloc/auth_bloc.dart';
import '../../../logic/event/auth_event.dart';
import '../../../logic/state/auth_state.dart';

class RegisterVerifyScreen extends StatelessWidget {
  final String mobile;

  const RegisterVerifyScreen({super.key, required this.mobile});

  @override
  Widget build(BuildContext context) {
    TextEditingController codeController = TextEditingController();
    return BlocProvider(
      create: (context) => AuthBloc(ApiService()),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColor.bgColor,
          body: Center(
            child: Padding(
              padding: EdgeInsets.only(right: 56.w, left: 56.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 300.w,
                    height: 122.h,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(Assets.png.watch.path),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 32.h),
                  Text(
                    "کد فعال سازی برای ${mobile} ارسال شد",
                    style: AppTextStyle.textFieldStyle,
                  ),
                  SizedBox(height: 12.h),
                  InkWell(
                    onTap: () {
                      GoRouter.of(context).pop();
                    },
                    child: Text(
                      "شماره اشتباه است/ ویرایش شماره",
                      style: AppTextStyle.textEditPhoneNumberStyle,
                    ),
                  ),
                  SizedBox(height: 48.h),
                  CustomTextField(
                    text: "کد فعال سازی را وارد کنید",
                    hintText: "- - - -",
                    controller: codeController,
                  ),
                  SizedBox(height: 16.h),
                  BlocConsumer<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is SmsCodeVerified) {
                        GoRouter.of(context).pushNamed('/registerSignUp');
                      }
                      if (state is AuthFailure) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(state.error)));
                      }
                    },
                    builder: (context, state) {
                      return CustomButton(
                        text: "ادامه",
                        onPressed: () {
                          context.read<AuthBloc>().add(
                            CheckSmsCodeEvent(mobile, codeController.text),
                          );
                        },
                        shape: ButtonShape.rectangle,
                        fullWidth: true,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
