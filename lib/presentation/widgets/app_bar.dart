import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:watch_shop/gen/assets.gen.dart';

PreferredSize buildCustomSignUpAppBar() {
  return PreferredSize(
    preferredSize: Size.fromHeight(68.h),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          Center(
            child: GestureDetector(
              //TODO: add onTab
              child: SvgPicture.asset(Assets.svg.vuesaxLinearDirectLeft),
            ),
          ),
        ],

        leading: Center(child: Text("ثبت نام")),
        elevation: 0,
      ),
    ),
  );
}
