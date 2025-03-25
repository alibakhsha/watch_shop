import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:watch_shop/constant/app_color.dart';
import 'package:watch_shop/presentation/widgets/custom_button.dart';
import 'package:watch_shop/presentation/widgets/profile.dart';
import 'package:watch_shop/presentation/widgets/text_fields.dart';

import '../../widgets/app_bar.dart';

class RegisterSignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.bgColor,
        appBar: buildCustomSignUpAppBar(() {
          GoRouter.of(context).pop();
        }),
        body: Center(
          child: Padding(
            padding: EdgeInsets.only(right: 42.w, left: 42.w),
            child: Column(
              children: [
                SizedBox(height: 32.h),
                CustomProfile(),
                SizedBox(height: 32.h),
                CustomTextField(
                  text: "نام و نام خانوادگی",
                  hintText: "نام و نام خانوادگی خود را با حروف فارسی وارد کنید",
                  controller: nameController,
                ),
                SizedBox(height: 20.h),
                CustomTextField(
                  text: "تلفن ثابت",
                  hintText: "شماره تلفن ثابت را با پیش شماره وارد بفرمایید",
                  controller: nameController,
                ),
                SizedBox(height: 20.h),
                CustomTextField(
                  text: "آدرس",
                  hintText: "آدرس پستی خود را وارد کنید",
                  controller: nameController,
                ),
                SizedBox(height: 20.h),
                CustomTextField(
                  text: "کد پستی",
                  hintText: "کد پستی  10 رقمی خود را وارد کنید",
                  controller: nameController,
                ),
                SizedBox(height: 20.h),
                CustomTextField(
                  text: "موقعیت مکانی",
                  hintText: "برای انتخاب موقعیت مکانی ضربه برنید",
                  controller: nameController,
                  hasIcon: true,
                ),
                SizedBox(height: 24.h),
                CustomButton(
                  text: "ثبت نام",
                  onPressed: () {},
                  shape: ButtonShape.rectangle,
                  fullWidth: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
