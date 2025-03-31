// presentation/widgets/custom_shell_screen.dart
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

  final List<String> _routes = const [
    '/home',
    '/cart',
    '/profile',
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final currentPath = GoRouter.of(context).routerDelegate.currentConfiguration.uri.toString();
    _selectedIndex = _routes.indexOf(currentPath);
    if (_selectedIndex == -1) _selectedIndex = 0;
  }

  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      debugPrint('Start navigation to ${_routes[index]} at ${DateTime.now()}');
      _selectedIndex = index;
      context.go(_routes[index]);
      debugPrint('End navigation at ${DateTime.now()}');
      setState(() {});
    }
  }

  PreferredSize? _buildAppBar(BuildContext context) {
    final currentPath = GoRouterState.of(context).uri.toString();

    if (currentPath == '/home') {
      return null;
    }

    String title = '';
    if (currentPath == '/cart') {
      title = 'سبد خرید';
    } else if (currentPath == '/profile') {
      title = 'پروفایل';
    }

    return buildCPAppBar(title);
  }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        backgroundColor: AppColor.bgColor,
        body: widget.child,
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          elevation: 4,
          height: 83.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildNavItem(index: 0, icon: Assets.svg.homeHashtag, label: 'خانه'),
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
            style: isSelected ? AppTextStyle.textBottomNavStyle1 : AppTextStyle.textBottomNavStyle2,
          ),
        ],
      ),
    );
  }
}