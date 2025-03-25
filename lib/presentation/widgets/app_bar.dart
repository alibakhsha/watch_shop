import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:watch_shop/constant/app_text_style.dart';
import 'package:watch_shop/gen/assets.gen.dart';

PreferredSize buildCustomSignUpAppBar(VoidCallback onPressed) {
  return PreferredSize(
    preferredSize: Size.fromHeight(68.h),
    child: AppBar(
      backgroundColor: Colors.white,
      actions: [
        Padding(
          padding: EdgeInsets.fromLTRB(12.w,12.h,0,12.h),
          child: Center(
            child: GestureDetector(
              //TODO: add onTab
              onTap: onPressed,
              child: SvgPicture.asset(Assets.svg.vuesaxLinearDirectLeft,width: 20.w,height: 20.h,),
            ),
          ),
        ),
      ],

      leading: Padding(
        padding: EdgeInsets.fromLTRB(0,12.h,12.w,12.h),
        child: Center(child: Text("ثبت نام",style: AppTextStyle.textAppBarStyle,)),
      ),
    ),
  );
}
