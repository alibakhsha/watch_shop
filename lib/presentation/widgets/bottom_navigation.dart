import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:watch_shop/gen/assets.gen.dart';
import 'package:watch_shop/presentation/widgets/custom_button.dart';

import '../../constant/app_color.dart';
import '../../constant/app_text_style.dart';
import '../../core/model/cart.dart';
import '../../logic/bloc/cart_bloc.dart';
import '../../logic/event/cart_event.dart';
import '../../logic/state/cart_state.dart';

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
            // ignore: deprecated_member_use
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

class CustomSingleProductBottomNav extends StatefulWidget {
  final double price;
  final int discount;
  final double discountPrice;
  final int productId;

  const CustomSingleProductBottomNav({
    super.key,
    required this.price,
    required this.discount,
    required this.discountPrice,
    required this.productId,
  });

  @override
  State<CustomSingleProductBottomNav> createState() =>
      _CustomSingleProductBottomNavState();
}

class _CustomSingleProductBottomNavState
    extends State<CustomSingleProductBottomNav> {
  int _localQuantity = 0;

  void _addToCart() {
    context.read<CartBloc>().add(
      AddProductToCart(productId: widget.productId, quantity: 1),
    );
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('محصول به سبد خرید اضافه شد')));
  }

  void _increment() {
    context.read<CartBloc>().add(IncreaseCartItemQuantity(widget.productId));
  }

  void _decrement(int currentQuantity) {
    if (currentQuantity > 1) {
      context.read<CartBloc>().add(DecreaseCartItemQuantity(widget.productId));
    } else {
      context.read<CartBloc>().add(DeleteCartItem(widget.productId));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartBloc, CartState>(
      listenWhen: (previous, current) => current is CartLoaded,
      listener: (context, state) {
        if (state is CartLoaded) {
          final foundItem = state.cartItems.firstWhere(
            (item) => item.productId == widget.productId,
            orElse:
                () => CartItem(
                  id: 0,
                  productId: widget.productId,
                  productTitle: '',
                  quantity: 0,
                  image: '',
                  price: 0.0,
                  priceDiscount: 0.0,
                ),
          );
          if (_localQuantity != foundItem.quantity) {
            setState(() {
              _localQuantity = foundItem.quantity;
            });
          }
        }
      },
      child: BottomAppBar(
        elevation: 1,
        color: Colors.white,
        height: 80.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _localQuantity == 0
                ? CustomButton(
                  text: "افزودن به سبد خرید",
                  onPressed: _addToCart,
                  shape: ButtonShape.rectangle,
                )
                : Row(
                  children: [
                    GestureDetector(
                      onTap: _increment,
                      child: SvgPicture.asset(Assets.svg.plus),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      "$_localQuantity عدد",
                      style: AppTextStyle.cartCountTextStyle,
                    ),
                    SizedBox(width: 8.w),
                    GestureDetector(
                      onTap: () => _decrement(_localQuantity),
                      child: SvgPicture.asset(Assets.svg.minus),
                    ),
                  ],
                ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    if (widget.discount != 0)
                      Container(
                        width: 34.w,
                        height: 18.h,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Center(
                          child: Text(
                            "%${widget.discount}",
                            style: AppTextStyle.productDiscountStyle,
                          ),
                        ),
                      ),
                    SizedBox(width: 6.w),
                    Text(
                      widget.discountPrice.toString(),
                      style: AppTextStyle.productPriceStyle,
                    ),
                  ],
                ),
                if (widget.discountPrice != widget.price)
                  Text(
                    widget.price.toString(),
                    style: AppTextStyle.productDiscountPriceStyle,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
