import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:watch_shop/constant/app_color.dart';
import 'package:watch_shop/logic/bloc/home_bloc.dart';
import 'package:watch_shop/logic/bloc/product_bloc.dart';
import 'package:watch_shop/logic/event/product_event.dart';
import 'package:watch_shop/logic/state/product_state.dart';
import 'package:watch_shop/presentation/widgets/product_card.dart';

import '../../logic/event/home_event.dart';
import '../../logic/state/home_state.dart';
import '../widgets/app_bar.dart';

class ProductsScreen extends StatelessWidget {
  final int categoryId;

  const ProductsScreen({super.key, required this.categoryId});
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProductBloc>(context).add(FetchProductsByCategory(categoryId));
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.bgColor,
        appBar: buildProductsAppBar(() {},context.pop, "لیست محصولات"),
        body: SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.fromLTRB(24.w,20.h,24.w,0),
            child: BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductLoaded) {
                  final product = state.products;
                  return Wrap(
                    spacing: 10.w,
                    children:
                        product
                            .map((product) => ProductCard(productModel: product))
                            .toList(),
                  );
                }
                return SizedBox();
              },
            ),
          ),
        ),
      ),
    );
  }
}
