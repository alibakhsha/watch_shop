import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:watch_shop/constant/app_text_style.dart';
import 'package:watch_shop/gen/assets.gen.dart';

PreferredSize buildCustomSignUpAppBar(VoidCallback onPressed) {
  return PreferredSize(
    preferredSize: Size.fromHeight(60.h),
    child: AppBar(
      backgroundColor: Colors.white,
      actions: [
        Padding(
          padding: EdgeInsets.fromLTRB(12.w, 12.h, 0, 12.h),
          child: Center(
            child: GestureDetector(
              //TODO: add onTab
              onTap: onPressed,
              child: SvgPicture.asset(
                Assets.svg.vuesaxLinearDirectLeft,
                width: 20.w,
                height: 20.h,
              ),
            ),
          ),
        ),
      ],

      leading: Padding(
        padding: EdgeInsets.fromLTRB(0, 12.h, 12.w, 12.h),
        child: Center(
          child: Text("ثبت نام", style: AppTextStyle.textAppBarStyle),
        ),
      ),
    ),
  );
}

PreferredSize buildProductsAppBar(
  VoidCallback onPressed1,
  VoidCallback onPressed2,
  String title,
) {
  return PreferredSize(
    preferredSize: Size.fromHeight(60.h),
    child: AppBar(
      elevation: 4,
      shadowColor: Colors.black,
      backgroundColor: Colors.white,
      actions: [
        Padding(
          padding: EdgeInsets.fromLTRB(12.w, 12.h, 0, 12.h),
          child: Center(
            child: GestureDetector(
              //TODO: add onTab
              onTap: onPressed1,
              child: SvgPicture.asset(
                Assets.svg.cart1,
                width: 30.w,
                height: 30.h,
              ),
            ),
          ),
        ),
      ],
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text(title, style: AppTextStyle.textAppBarProductStyle)],
      ),

      leading: Padding(
        padding: EdgeInsets.fromLTRB(0, 12.h, 12.w, 12.h),
        child: Center(
          child: GestureDetector(
            onTap: onPressed2,
            child: SvgPicture.asset(
              Assets.svg.group226,
              width: 14.w,
              height: 14.h,
            ),
          ),
        ),
      ),
    ),
  );
}

PreferredSize buildCPAppBar(String title) {
  return PreferredSize(
    preferredSize: Size.fromHeight(60.h),
    child: AppBar(
      elevation: 4,
      shadowColor: Colors.black,
      backgroundColor: Colors.white,
      leadingWidth: 80.w,
      leading: Padding(
        padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 12.h),
        child: Center(
          child: Text(title, style: AppTextStyle.textAppBarProductStyle),
        ),
      ),
    ),
  );
}
