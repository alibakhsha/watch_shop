import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watch_shop/constant/app_color.dart';
import 'package:watch_shop/presentation/widgets/app_bar.dart';
import 'package:watch_shop/presentation/widgets/custom_button.dart';
import 'package:watch_shop/presentation/widgets/profile.dart';
import 'package:watch_shop/presentation/widgets/text_fields.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.bgColor,
        appBar: buildCustomSignUpAppBar(),
        body: Padding(
          padding:  EdgeInsets.only(top: 20.h,left: 24.w,right: 24.w),
          child: Column(
            children: [
              SizedBox(height: 32.h),
              // CustomTextField(text: "نام", hintText: "علی",hasIcon: true,),
              CustomButton(text: "سلام", onPressed: (){}, shape: ButtonShape.rectangle,fullWidth: true,),
              CustomProfile()

            ],
          ),
        ),
      ),
    );
  }
}
