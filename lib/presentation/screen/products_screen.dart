import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:watch_shop/constant/app_color.dart';
import 'package:watch_shop/constant/app_text_style.dart';
import 'package:watch_shop/logic/bloc/brand_bloc.dart';
import 'package:watch_shop/logic/bloc/product_bloc.dart';
import 'package:watch_shop/logic/event/brand_event.dart';
import 'package:watch_shop/logic/event/product_event.dart';
import 'package:watch_shop/logic/state/brand_state.dart';
import 'package:watch_shop/logic/state/product_state.dart';
import 'package:watch_shop/presentation/widgets/product_card.dart';
import '../../core/model/product_model.dart';
import '../widgets/app_bar.dart';

class ProductsScreen extends StatelessWidget {
  final int? categoryId;
  final List<ProductModel>? products;
  final String title;

  const ProductsScreen({
    super.key,
    this.categoryId,
    this.products,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    // context.read<BrandBloc>().add(FetchBrands());
    if (categoryId != null) {
      BlocProvider.of<ProductBloc>(
        context,
      ).add(FetchProductsByCategory(categoryId!));
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.bgColor,
        appBar: buildProductsAppBar(() {}, context.pop, title),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(24.w, 20.h, 24.w, 0),
            child: Column(
              children: [
                // SizedBox(height: 24.h),
                _buildBrandsSection(context),
                SizedBox(height: 48.h),
                BlocBuilder<ProductBloc, ProductState>(
                  builder: (context, state) {
                    if (state is ProductLoading) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (state is ProductLoaded) {
                      final productList = products ?? state.products;
                      return Wrap(
                        spacing: 10.w,
                        children:
                            productList
                                .map(
                                  (product) =>
                                      ProductCard(productModel: product),
                                )
                                .toList(),
                      );
                    }
                    return Center(child: Text("محصولی یافت نشد!"));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBrandsSection(BuildContext context) {
    return BlocBuilder<BrandBloc, BrandState>(
      builder: (context, state) {
        debugPrint(state.toString());
        if (state is BrandLoaded) {
          debugPrint("Brands Loaded: ${state.brands.length}");
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Wrap(
              spacing: 10.w,
              children:
                  state.brands
                      .map(
                        (brand) => IntrinsicWidth(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 24.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColor.bgButtonColor,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Center(
                              child: Text(
                                brand.title,
                                style: AppTextStyle.textButtonStyle,
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
            ),
          );
        }
        return SizedBox();
      },
    );
  }
}
