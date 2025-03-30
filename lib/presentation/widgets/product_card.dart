import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watch_shop/constant/app_color.dart';
import 'package:watch_shop/constant/app_text_style.dart';

import '../../core/model/product_model.dart';

enum ProductType { normal, discount, timedDiscount }

class ProductCard extends StatelessWidget {
  final ProductModel productModel;

  const ProductCard({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 182.w,
      height: 320.h,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color.fromRGBO(239, 239, 239, 1), Colors.white],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              child: Image.network(
                productModel.image,
                height: 120.h,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            SizedBox(height: 16.h),
            Text(productModel.title, style: AppTextStyle.productTitleStyle),
            SizedBox(height: 16.h),

            if (productModel.productType == ProductType.normal)
              _buildNormalPrice(),
            if (productModel.productType == ProductType.discount)
              _buildDiscountPrice(),
            if (productModel.productType == ProductType.timedDiscount)
              _buildTimedDiscount(),
          ],
        ),
      ),
    );
  }

  Widget _buildNormalPrice() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          "${productModel.price}تومان",
          style: AppTextStyle.productPriceStyle,
        ),
      ],
    );
  }

  Widget _buildDiscountPrice() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 34.w,
          height: 18.h,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
          child: Center(
            child: Text(
              "%${productModel.discount}",
              style: AppTextStyle.productDiscountStyle,
            ),
          ),
        ),
        Column(
          children: [
            Text(
              "${productModel.price}تومان",
              style: AppTextStyle.productPriceStyle,
            ),
            SizedBox(height: 4.h),
            Text(
              productModel.discountPrice.toString(),
              style: AppTextStyle.productDiscountPriceStyle,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTimedDiscount() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 34.w,
              height: 18.h,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              child: Center(
                child: Text(
                  "%${productModel.discount}",
                  style: AppTextStyle.productDiscountStyle,
                ),
              ),
            ),
            Column(
              children: [
                Text(
                  "${productModel.price}تومان",
                  style: AppTextStyle.productPriceStyle,
                ),
                SizedBox(height: 4.h),
                Text(
                  productModel.discountPrice.toString(),
                  style: AppTextStyle.productDiscountPriceStyle,
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 4.h),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Divider(height: 5, color: AppColor.productTimePriceColor),
        ),
        SizedBox(height: 6.h),
        Text(
          productModel.specialExpiration.toString(),
          style: AppTextStyle.productDiscountTimeStyle,
          textAlign: TextAlign.center,
          overflow: TextOverflow.clip,
          maxLines: 1,
        ),
      ],
    );
  }
}
