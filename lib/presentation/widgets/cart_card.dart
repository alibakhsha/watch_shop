import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:watch_shop/constant/app_color.dart';
import 'package:watch_shop/constant/app_text_style.dart';
import 'package:watch_shop/gen/assets.gen.dart';

class CustomCartCard extends StatelessWidget {
  final String imagePath;
  final String name;
  final String price;
  final String priceDiscount;
  final int quantity;
  final VoidCallback onPlusTap;
  final VoidCallback onMinusTap;
  final VoidCallback onDeleteTap;

  const CustomCartCard({
    super.key,
    required this.imagePath,
    required this.name,
    required this.price,
    required this.priceDiscount,
    required this.quantity,
    required this.onPlusTap,
    required this.onMinusTap,
    required this.onDeleteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160.h,
      decoration: BoxDecoration(
        color: AppColor.profileBoxColor,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Container(
              width: 144.w,
              decoration: BoxDecoration(
                image: DecorationImage(image: NetworkImage(imagePath)),
              ),
            ),
            SizedBox(width: 6.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: AppTextStyle.cartTitleTextStyle),
                  SizedBox(height: 12.h),
                  Text(
                    "قیمت : $price تومان",
                    style: AppTextStyle.cartPriceTextStyle,
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    "با تخفیف : $priceDiscount تومان",
                    style: AppTextStyle.cartPriceDiscountTextStyle,
                  ),
                  SizedBox(height: 6.h),
                  Divider(height: 1, color: Color.fromRGBO(217, 220, 228, 1)),
                  SizedBox(height: 6.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: onPlusTap,
                            child: SvgPicture.asset(Assets.svg.plus),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            "${quantity.toString()} عدد",
                            style: AppTextStyle.cartCountTextStyle,
                          ),
                          SizedBox(width: 8.w),
                          GestureDetector(
                            onTap: onMinusTap,
                            child: SvgPicture.asset(Assets.svg.minus),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: onDeleteTap,
                        child: SvgPicture.asset(Assets.svg.delete),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
