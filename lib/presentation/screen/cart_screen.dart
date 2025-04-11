import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watch_shop/constant/app_text_style.dart';
import 'package:watch_shop/logic/bloc/cart_bloc.dart';
import 'package:watch_shop/logic/event/cart_event.dart';
import 'package:watch_shop/logic/state/cart_state.dart';
import 'package:watch_shop/presentation/widgets/custom_button.dart';

import '../../services/api_sevice.dart';
import '../widgets/cart_card.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartBloc(ApiService())..add(LoadCart()),
      child: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CartLoaded) {
            final cartItems = state.cartItems;
            final totalPrice = state.totalPrice;

            return Column(
              children: [
                Expanded(
                  child:
                      cartItems.isEmpty
                          ? const Center(child: Text('سبد خرید خالی است'))
                          : ListView.separated(
                            padding: EdgeInsets.symmetric(
                              vertical: 16.h,
                              horizontal: 16.w,
                            ),
                            itemCount: cartItems.length,
                            separatorBuilder:
                                (context, index) => SizedBox(height: 12.h),
                            itemBuilder: (context, index) {
                              final item = cartItems[index];
                              return CustomCartCard(
                                imagePath: item.image,
                                name: item.productTitle,
                                price: item.price.toStringAsFixed(0),
                                priceDiscount: item.priceDiscount
                                    .toStringAsFixed(0),
                                quantity: item.quantity,
                                onPlusTap: () {
                                  context.read<CartBloc>().add(
                                    IncreaseCartItemQuantity(item.productId),
                                  );
                                },
                                onMinusTap: () {
                                  if (item.quantity > 1) {
                                    context.read<CartBloc>().add(
                                      DecreaseCartItemQuantity(item.productId),
                                    );
                                  }
                                },
                                onDeleteTap: () {
                                  context.read<CartBloc>().add(
                                    DeleteCartItem(item.productId),
                                  );
                                },
                              );
                            },
                          ),
                ),
                _buildTotalPriceAndCheckout(context, totalPrice),
              ],
            );
          } else if (state is CartError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildTotalPriceAndCheckout(BuildContext context, double totalPrice) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomButton(
            text: "ادامه فرایند خرید",
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('ادامه فرآیند خرید')),
              );
            },
            shape: ButtonShape.rectangle,
          ),
          Text(
            'جمع: ${totalPrice.toStringAsFixed(0)} تومان',
            style: AppTextStyle.totalPriceTextStyle,
          ),
          // ElevatedButton(
          //   onPressed: () {
          //     ScaffoldMessenger.of(context).showSnackBar(
          //       const SnackBar(content: Text('ادامه فرآیند خرید')),
          //     );
          //   },
          //   style: ElevatedButton.styleFrom(
          //     backgroundColor: AppColor.bgButtonColor,
          //     padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
          //   ),
          //   child: Text(
          //     'ادامه فرآیند خرید',
          //     style: TextStyle(fontSize: 16.sp, color: Colors.white),
          //   ),
          // ),
        ],
      ),
    );
  }
}
