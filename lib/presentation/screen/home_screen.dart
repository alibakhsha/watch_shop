import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watch_shop/constant/app_color.dart';
import 'package:watch_shop/constant/app_text_style.dart';
import 'package:watch_shop/logic/state/home_state.dart';

import '../../gen/assets.gen.dart';
import '../../logic/bloc/home_bloc.dart';
import '../../logic/event/home_event.dart';
import '../widgets/home_screen_banner.dart';
import '../widgets/text_fields.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<HomeBloc>(context).add(FetchHomeData());
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.bgColor,
        body: Padding(
          padding: EdgeInsets.only(top: 20.h, left: 24.w, right: 24.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildSearchSection(),
                SizedBox(height: 24.h),
                HomeScreenBanner(),
                SizedBox(height: 24.h),
                _buildCategoryItems()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchSection(){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(50)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(80),
            blurRadius: 2.0,
            spreadRadius: 0.2,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 20),
          prefixIcon: Image.asset(
            Assets.png.watch.path,
            width: 98.w,
            height: 38.h,
          ),
          suffixIcon: Icon(Icons.search, size: 24),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
          hintText: "جستجوی محصولات",
          hintStyle: AppTextStyle.textHintFieldStyle,
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

  Widget _buildCategoryItems() {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoaded) {
          final images =
              state.categories
                  .map((categoryImage) => categoryImage.image)
                  .toList();
          final title =
              state.categories
                  .map((categoryName) => categoryName.title)
                  .toList();
          return Wrap(
            spacing: 26.w,
            runSpacing: 10.h,
            children: [
              for (var i = 0; i < state.categories.length; i++)
                Column(
                  children: [
                    Container(
                      width: 74.w,
                      height: 74.h,
                      decoration: BoxDecoration(
                        color: Colors.grey.withAlpha(20),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        image: DecorationImage(image: NetworkImage(images[i])),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(title[i], style: AppTextStyle.categoryTitleStyle),
                  ],
                ),
            ],
          );
        }
        return SizedBox();
      },
    );
  }
}
