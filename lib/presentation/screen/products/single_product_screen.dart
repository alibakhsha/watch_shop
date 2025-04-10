import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:watch_shop/constant/app_color.dart';
import 'package:watch_shop/constant/app_text_style.dart';
import 'package:watch_shop/logic/bloc/product_details_bloc.dart';
import 'package:watch_shop/logic/event/product_details_event.dart';
import 'package:watch_shop/logic/state/product_details_state.dart';
import 'package:watch_shop/presentation/widgets/bottom_navigation.dart';
import 'package:watch_shop/services/api_sevice.dart';

import '../../../core/model/product_details_model.dart';
import '../../widgets/app_bar.dart';

class SingleProductScreen extends StatelessWidget {
  final int productId;

  const SingleProductScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create:
            (context) =>
                ProductDetailsBloc(ApiService())
                  ..add(LoadProductDetailsById(productId)),
        child: BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
          builder: (context, state) {
            if (state is ProductDetailsLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ProductDetailsLoaded) {
              final ValueNotifier<int> selectedTab = ValueNotifier(0);
              final product = state.productDetails;
              return Scaffold(
                backgroundColor: AppColor.bgColor,
                appBar: buildProductsAppBar(() {}, () {
                  context.pop();
                }, product.title),

                body: Padding(
                  padding: EdgeInsets.fromLTRB(24.w, 10.h, 24.w, 0),
                  child: Column(
                    children: [
                      _buildProductImageSection(product),
                      SizedBox(height: 12.h),
                      _buildBodySection(product, selectedTab),
                    ],
                  ),
                ),
                bottomNavigationBar: CustomSingleProductBottomNav(
                  price: product.price,
                  discount: product.discount,
                  discountPrice: product.discountPrice,
                ),
              );
            }
            return SizedBox();
          },
        ),
      ),
    );
  }
  Widget _buildProductImageSection(ProductDetails product){
    return Container(
      height: 200.h,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(product.image),
        ),
      ),
    );
  }
  
  Widget _buildBodySection(ProductDetails product,ValueNotifier<int> selectedTab ){
    return Container(
      height: 440.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    product.titleEn,
                    style:
                    AppTextStyle.singleProductTextStyle1,
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Row(
                children: [
                  Text(
                    product.title,
                    style:
                    AppTextStyle.singleProductTextStyle2,
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Divider(
                color: Color.fromRGBO(248, 248, 248, 1),
              ),
              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      selectedTab.value = 0;
                    },
                    child: ValueListenableBuilder<int>(
                      valueListenable: selectedTab,
                      builder: (context, value, child) {
                        return Text(
                          "خصوصیات",
                          style:
                          value == 0
                              ? AppTextStyle
                              .singleProductTextStyle1
                              : AppTextStyle
                              .singleProductTextStyle2,
                        );
                      },
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      selectedTab.value = 1;
                    },
                    child: ValueListenableBuilder<int>(
                      valueListenable: selectedTab,
                      builder: (context, value, child) {
                        return Text(
                          "نقد و بررسی",
                          style:
                          value == 1
                              ? AppTextStyle
                              .singleProductTextStyle1
                              : AppTextStyle
                              .singleProductTextStyle2,
                        );
                      },
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      selectedTab.value = 2;
                    },
                    child: ValueListenableBuilder<int>(
                      valueListenable: selectedTab,
                      builder: (context, value, child) {
                        return Text(
                          "نظرات",
                          style:
                          value == 2
                              ? AppTextStyle
                              .singleProductTextStyle1
                              : AppTextStyle
                              .singleProductTextStyle2,
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              ValueListenableBuilder<int>(
                valueListenable: selectedTab,
                builder: (context, value, child) {
                  switch (value) {
                    case 0:
                      return Html(
                        data: product.description,
                        style: {
                          '*': Style.fromTextStyle(
                            AppTextStyle
                                .singleProductTextStyle2,
                          ),
                        },
                      );
                    case 1:
                      return Html(
                        data: product.discussion,
                        style: {
                          '*': Style.fromTextStyle(
                            AppTextStyle
                                .singleProductTextStyle2,
                          ),
                        },
                      );
                    case 2:
                      return Column(
                        children: [
                          product.comments.isEmpty
                              ? Text(
                            'نظری وجود ندارد',
                            style: AppTextStyle.singleProductTextStyle2,
                          )
                              : ListView.separated(
                            shrinkWrap: true,
                            physics:
                            const NeverScrollableScrollPhysics(),
                            itemCount:
                            product.comments.length,
                            itemBuilder: (
                                context,
                                index,
                                ) {
                              final comment = product.comments[index];
                              return ListTile(
                                title: Text(comment.user,
                                  style:
                                  AppTextStyle
                                      .singleProductTextStyle1,
                                ),
                                subtitle: Text(
                                  comment.body,
                                  style:
                                  AppTextStyle
                                      .singleProductTextStyle2,
                                ),
                              );
                            },
                            separatorBuilder:
                                (context, index) =>
                                Divider(
                                  color: Color.fromRGBO(
                                    84,
                                    84,
                                    84,
                                    1,
                                  ),
                                ),
                          ),
                        ],
                      );
                    default:
                      return SizedBox();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
