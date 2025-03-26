import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watch_shop/constant/app_color.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.bgColor,
        // appBar: buildCustomSignUpAppBar(),
        body: Padding(
          padding:  EdgeInsets.only(top: 20.h,left: 24.w,right: 24.w),
          child: Column(
            children: [

            ],
          ),
        ),
      ),
    );
  }
}
