import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:watch_shop/constant/app_color.dart';
import 'package:watch_shop/constant/app_text_style.dart';
import 'package:watch_shop/core/enums/product_source.dart';
import 'package:watch_shop/logic/bloc/brand_bloc.dart';
import 'package:watch_shop/logic/bloc/product_bloc.dart';
import 'package:watch_shop/logic/event/product_event.dart';
import 'package:watch_shop/logic/state/brand_state.dart';
import 'package:watch_shop/logic/state/product_state.dart';
import 'package:watch_shop/presentation/widgets/product_card.dart';
import '../../../core/model/products_model.dart';

class ProductsScreen extends StatelessWidget {
  final ProductSource productSource;
  final int sourceId;
  final List<ProductsModel>? products;
  final String title;
  final String? searchQuery; // اضافه کردن searchQuery

  const ProductsScreen({
    super.key,
    required this.productSource,
    required this.sourceId,
    this.products,
    required this.title,
    this.searchQuery, // اضافه کردن به سازنده
  });

  @override
  Widget build(BuildContext context) {
    if (products == null) {
      if (productSource == ProductSource.category) {
        BlocProvider.of<ProductBloc>(context).add(FetchProductsByCategory(sourceId));
      } else if (productSource == ProductSource.brand) {
        BlocProvider.of<ProductBloc>(context).add(FetchProductsByBrand(sourceId));
      } else if (productSource == ProductSource.search) {
        if (searchQuery != null && searchQuery!.isNotEmpty) {
          BlocProvider.of<ProductBloc>(context).add(FetchProductsBySearch(searchQuery!));
        }
      } else {
        BlocProvider.of<ProductBloc>(context).add(FetchProducts(productSource, sourceId));
      }
    }

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(24.w, 20.h, 24.w, 0),
        child: Column(
          children: [
            _buildBrandsSection(context),
            SizedBox(height: 48.h),
            BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is ProductLoaded) {
                  final productList = products ?? state.products;
                  debugPrint("Loaded Products: $productList");
                  return Wrap(
                    spacing: 10.w,
                    children: productList
                        .map(
                          (product) => ProductCard(productModel: product),
                    )
                        .toList(),
                  );
                }
                if (state is ProductError) {
                  debugPrint("Product Error: ${state.message}");
                  return Center(child: Text("خطا: ${state.message}"));
                }
                debugPrint("Product State: $state");
                return const Center(child: Text("محصولی یافت نشد!"));
              },
            ),
          ],
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
              children: state.brands
                  .map(
                    (brand) => GestureDetector(
                  onTap: () {
                    context.pushReplacement(
                      "/products/brand/${brand.id}",
                      extra: {'title': "محصولات برند ${brand.title}"},
                    );
                  },
                  child: IntrinsicWidth(
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
                ),
              )
                  .toList(),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}