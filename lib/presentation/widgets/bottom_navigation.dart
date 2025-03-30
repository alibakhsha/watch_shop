import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:watch_shop/gen/assets.gen.dart';

import '../../constant/app_color.dart';
import '../../constant/app_text_style.dart';

class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({super.key});

  final List<String> _routes = const ['/home', '/cart', '/profile'];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: GoRouter.of(context).routeInformationProvider,
      builder: (context, RouteInformation routeInfo, child) {
        final currentPath = routeInfo.uri.toString();

        return BottomAppBar(
          color: Colors.white,
          elevation: 4,
          height: 83.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildNavItem(
                context: context,
                index: 0,
                icon: Assets.svg.homeHashtag,
                label: 'خانه',
                currentPath: currentPath,
              ),
              _buildNavItem(
                context: context,
                index: 1,
                icon: Assets.svg.cart,
                label: 'سبدخرید',
                currentPath: currentPath,
              ),
              _buildNavItem(
                context: context,
                index: 2,
                icon: Assets.svg.user,
                label: 'پروفایل',
                currentPath: currentPath,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required int index,
    required String icon,
    required String label,
    required String currentPath,
  }) {
    final isSelected = currentPath == _routes[index];
    return GestureDetector(
      onTap: () => context.go(_routes[index]),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            icon,
            color: isSelected ? Colors.black : AppColor.bottomNavIcon2Color,
            width: 30.w,
            height: 30.h,
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style:
                isSelected
                    ? AppTextStyle.textBottomNavStyle1
                    : AppTextStyle.textBottomNavStyle2,
          ),
        ],
      ),
    );
  }
}
