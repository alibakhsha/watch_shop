import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/model/home_page.dart';
import '../../core/model/product_model.dart';
import '../../services/api_sevice.dart';
import '../event/home_event.dart';
import '../state/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  final ApiService apiService;

  HomeBloc(this.apiService) : super(HomeInitial()) {
    on<FetchHomeData>((event, emit) async {
      emit(HomeLoading());
      try {
        final response = await apiService.getHomeData();


        if (response['result']) {
          final data = response['data'];
          
          debugPrint('Data: $data');

          List<SliderModel> sliders =
          (data['sliders'] as List)
              .map((e) => SliderModel.fromJson(e))
              .toList();
          List<CategoryModel> categories =
          (data['categories'] as List)
              .map((e) => CategoryModel.fromJson(e))
              .toList();
          List<ProductModel> amazingProducts =
          (data['amazing_products'] as List)
              .map((e) => ProductModel.fromJson(e))
              .toList();

          List<ProductModel> mostSellerProducts =
          (data['most_seller_products'] as List)
              .map((e) => ProductModel.fromJson(e))
              .toList();
          List<ProductModel> newestProducts =
          (data['newest_products'] as List)
              .map((e) => ProductModel.fromJson(e))
              .toList();

          emit(
            HomeLoaded(
              sliders: sliders,
              categories: categories,
              amazingProducts: amazingProducts,
              mostSellerProducts: mostSellerProducts,
              newestProducts: newestProducts,
            ),
          );
        } else {
          emit(HomeError("Failed to load data"));
        }
      } catch (e) {
        debugPrint('Error: $e'); // چاپ خطا برای بررسی بهتر
        emit(HomeError(e.toString()));
      }
    });

  }
}
