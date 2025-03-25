import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watch_shop/constant/app_color.dart';
import 'package:watch_shop/gen/assets.gen.dart';
import 'package:watch_shop/logic/bloc/auth_bloc.dart';
import 'package:watch_shop/presentation/widgets/custom_button.dart';
import 'package:watch_shop/presentation/widgets/text_fields.dart';
import 'package:watch_shop/services/api_sevice.dart';

class RegisterIntroScreen extends StatelessWidget {
  final TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=> AuthBloc(apiService: ApiService()),
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
                  CustomButton(
                    text: "ارسال کد فعال سازی",
                    onPressed: () {},
                    shape: ButtonShape.rectangle,
                    fullWidth: true,
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
