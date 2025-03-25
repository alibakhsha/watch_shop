import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:watch_shop/constant/app_text_style.dart';
import 'package:watch_shop/gen/assets.gen.dart';

class CustomProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //TODO: select profile in gallery???!!!!!!!!!
    return Column(
      children: [
        Container(
          width: 72.w,
          height: 72.h,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(Assets.png.user.path)),
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(height: 12.h),
        Text("انتخاب تصویر", style: AppTextStyle.textFieldStyle),
      ],
    );
  }
}
