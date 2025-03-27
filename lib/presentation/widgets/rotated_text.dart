import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:watch_shop/constant/app_text_style.dart';
import 'package:watch_shop/gen/assets.gen.dart';

class RotatedText extends StatelessWidget {
  final String title;
  final Color textColor;

  const RotatedText({super.key, required this.title, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 1,
      child: Column(
        children: [Text(title, style: TextStyle(
          fontFamily: "Dana",
          fontSize: 26.w,
          color: textColor,
        )),
        SizedBox(height: 8.h,),
        Row(
          children: [
            Text("مشاهده همه",style: AppTextStyle.textRotateStyle2,),
            SizedBox(width: 4.w,),
            SvgPicture.asset(Assets.svg.vuesaxLinearDirectLeft)
          ],
        )
        ],
        
      ),
    );
  }
}
