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
import '../../core/model/product_model.dart';
import '../widgets/app_bar.dart';

// class ProductsScreen extends StatelessWidget {
//   final int categoryId;
//
//   const ProductsScreen({super.key, required this.categoryId});
//   @override
//   Widget build(BuildContext context) {
//     BlocProvider.of<ProductBloc>(context).add(FetchProductsByCategory(categoryId));
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: AppColor.bgColor,
//         appBar: buildProductsAppBar(() {},context.pop, "لیست محصولات"),
//         body: SingleChildScrollView(
//           child: Padding(
//             padding:  EdgeInsets.fromLTRB(24.w,20.h,24.w,0),
//             child: BlocBuilder<ProductBloc, ProductState>(
//               builder: (context, state) {
//                 if (state is ProductLoaded) {
//                   final product = state.products;
//                   return Wrap(
//                     spacing: 10.w,
//                     children:
//                         product
//                             .map((product) => ProductCard(productModel: product))
//                             .toList(),
//                   );
//                 }
//                 return SizedBox();
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//

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
    if (categoryId != null) {
      BlocProvider.of<ProductBloc>(
        context,
      ).add(FetchProductsByCategory(categoryId!));
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.bgColor,
        appBar: buildProductsAppBar(() {},context.pop, title),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(24.w, 20.h, 24.w, 0),
            child: BlocBuilder<ProductBloc, ProductState>(
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
                              (product) => ProductCard(productModel: product),
                            )
                            .toList(),
                  );
                }
                return Center(child: Text("محصولی یافت نشد!"));
              },
            ),
          ),
        ),
      ),
    );
  }
}
