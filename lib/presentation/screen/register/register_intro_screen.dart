import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:watch_shop/constant/app_color.dart';
import 'package:watch_shop/core/route/route_name.dart';
import 'package:watch_shop/gen/assets.gen.dart';
import 'package:watch_shop/logic/bloc/auth_bloc.dart';
import 'package:watch_shop/presentation/widgets/custom_button.dart';
import 'package:watch_shop/presentation/widgets/text_fields.dart';
import 'package:watch_shop/services/api_sevice.dart';

import '../../../logic/event/auth_event.dart';
import '../../../logic/state/auth_state.dart';

class RegisterIntroScreen extends StatelessWidget {
  final TextEditingController phoneController = TextEditingController();

  RegisterIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  SizedBox(height: 100.h),
                  CustomTextField(
                    text: "شماره تماس خود را وارد کنید",
                    hintText: "مثل :  09121114466",
                    controller: phoneController,
                  ),
                  SizedBox(height: 16.h),
                  BlocConsumer<AuthBloc, AuthState>(
                    builder: (context, state) {
                      if (state is AuthLoading) {
                        return CircularProgressIndicator();
                      }
                      return CustomButton(
                        text: "ارسال کد فعال سازی",
                        onPressed: () {
                          String mobile = phoneController.text;
                          context.read<AuthBloc>().add(
                            SendSmsEvent(mobile),
                          );
                        },
                        shape: ButtonShape.rectangle,
                        fullWidth: true,
                      );
                    },
                    listener: (context, state) {
                      if (state is AuthSuccess) {
                        GoRouter.of(context).pushReplacement(
                          RouteName.registerVerify,
                          extra: phoneController.text,
                        );
                      } else if (state is AuthFailure) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(state.error)));
                      }
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
