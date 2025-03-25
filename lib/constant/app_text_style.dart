import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watch_shop/constant/app_color.dart';

class AppTextStyle {
  static var textFieldStyle = TextStyle(
    fontFamily: "Dana",
    fontSize: 12.w,
    fontWeight: FontWeight.w700,
    color: Colors.black
  );
  static var textHintFieldStyle = TextStyle(
    fontFamily: "Dana",
    fontSize: 13.w,
    color: AppColor.hintTextColor
  );
  static var textButtonStyle = TextStyle(
    fontFamily: "Dana",
    fontSize: 13.w,
    color: AppColor.textButtonColor
  );
}