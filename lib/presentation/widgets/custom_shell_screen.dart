import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:watch_shop/gen/assets.gen.dart';
import '../../constant/app_color.dart';
import '../../constant/app_text_style.dart';
import 'app_bar.dart';

class CustomShellScreen extends StatefulWidget {
  final Widget child;

  const CustomShellScreen({super.key, required this.child});

  @override
  State<CustomShellScreen> createState() => _CustomShellScreenState();
}

class _CustomShellScreenState extends State<CustomShellScreen> {
  int _selectedIndex = 0;
  final List<String> _routes = ['/home', '/cart', '/profile'];

  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
      context.go(_routes[index]);
    }
  }

  PreferredSize? _buildAppBar(BuildContext context) {
    final currentPath = GoRouterState.of(context).uri.toString();

    // اگه مسیر /home بود، اپ‌بار نمایش داده نشه
    if (currentPath == '/home') {
      return null;
    }

    // عنوان اپ‌بار بر اساس مسیر
    String title = '';
    if (currentPath == '/cart') {
      title = 'سبد خرید';
    } else if (currentPath == '/profile') {
      title = 'پروفایل';
    } else if (currentPath.startsWith('/products')) {
      final extra =
          GoRouterState.of(context).extra as Map<String, dynamic>? ?? {};
      title = extra['title'] as String? ?? "محصولات";
      // برای مسیر /products از buildProductsAppBar استفاده می‌کنیم
      return buildProductsAppBar(
        () => context.go('/cart'), // onPressed1: رفتن به سبد خرید
        () => context.pop(), // onPressed2: برگشت به صفحه قبلی
        title,
      );
    }

    return buildCPAppBar(title);
  }

  @override
  Widget build(BuildContext context) {
    final currentPath = GoRouterState.of(context).uri.toString();
    // اگه مسیر /products باشه، تب Home رو فعال نگه می‌داریم
    if (currentPath.startsWith('/products')) {
      _selectedIndex = 0; // تب Home
    } else {
      _selectedIndex = _routes.indexWhere((route) => currentPath == route);
      if (_selectedIndex == -1) _selectedIndex = 0;
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.bgColor,
        appBar: _buildAppBar(context),
        body: widget.child,
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          elevation: 4,
          height: 83.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildNavItem(
                index: 0,
                icon: Assets.svg.homeHashtag,
                label: 'خانه',
              ),
              _buildNavItem(index: 1, icon: Assets.svg.cart, label: 'سبدخرید'),
              _buildNavItem(index: 2, icon: Assets.svg.user, label: 'پروفایل'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required String icon,
    required String label,
  }) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => _onItemTapped(index),
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

// _buildNavItem(index: 0, icon: Assets.svg.homeHashtag, label: 'خانه'),
// _buildNavItem(index: 1, icon: Assets.svg.cart, label: 'سبدخرید'),
// _buildNavItem(index: 2, icon: Assets.svg.user, label: 'پروفایل'),

// bottomNavigationBar: BottomAppBar(
// color: Colors.white,
// elevation: 4,
// height: 83.h,
// child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceAround,
// crossAxisAlignment: CrossAxisAlignment.center,
// children: [
// _buildNavItem(index: 0, icon: Assets.svg.homeHashtag, label: 'خانه'),
// _buildNavItem(index: 1, icon: Assets.svg.cart, label: 'سبدخرید'),
// _buildNavItem(index: 2, icon: Assets.svg.user, label: 'پروفایل'),
// ],
// ),
// ),
