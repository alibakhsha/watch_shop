import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:watch_shop/constant/app_color.dart';
import 'package:watch_shop/constant/app_text_style.dart';
import 'package:watch_shop/gen/assets.gen.dart';

class CustomTextField extends StatelessWidget {
  final String text;
  final String hintText;
  final bool hasIcon;
  final String iconPath;
  final TextEditingController controller;

  CustomTextField({
    super.key,
    required this.text,
    required this.hintText,
    this.hasIcon = false,
    String? iconPath, required this.controller,
  }) : iconPath = iconPath ?? Assets.svg.vuesaxLinearLocationAdd;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [Text(text, style: AppTextStyle.textFieldStyle)]),
        SizedBox(height: 12.h),
        TextField(
          controller: controller,
          decoration:
              !hasIcon
                  ? InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: AppColor.textFieldBorderColor,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    hintText: hintText,
                    hintStyle: AppTextStyle.textHintFieldStyle,
                    filled: true,
                    fillColor: Colors.white,
                    focusColor: AppColor.textFieldFocusBorderColor,
                  )
                  : InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                    suffixIcon: SvgPicture.asset(
                      iconPath,
                      width: 12.w,
                      height: 12.h,
                    ),
                    // contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: AppColor.textFieldBorderColor,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    hintText: hintText,
                    hintStyle: AppTextStyle.textHintFieldStyle,
                    filled: true,
                    fillColor: Colors.white,
                    focusColor: AppColor.textFieldFocusBorderColor,

                    // icon: SvgPicture.asset(iconPath),
                  ),
        ),
      ],
    );
  }
}
