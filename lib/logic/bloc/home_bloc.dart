import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/cupertino.dart';

import '../../core/model/home_page.dart';
import '../../core/model/product_model.dart';
import '../../services/api_sevice.dart';
import '../event/home_event.dart';
import '../state/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ApiService apiService;

  HomeBloc(this.apiService) : super(HomeInitial()) {
    on<FetchHomeData>(_onFetchHomeData);
  }

  Future<void> _onFetchHomeData(
    FetchHomeData event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    try {
      final response = await apiService.get(
        '/public/api/v1/home',
        headers: {'accept': 'application/json', 'X-CSRF-TOKEN': ''},
      );

      debugPrint('Home Data Response Status: ${response.statusCode}');
      debugPrint('Home Data Response: ${response.data}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data ?? {};
        final Map<String, dynamic> data =
            responseData['data'] ?? {}; // دسترسی به زیرمجموعه 'data'

        // پرینت برای دیباگ
        debugPrint('Sliders Raw: ${data['sliders']}');
        debugPrint('Categories Raw: ${data['categories']}');
        debugPrint('Amazing Products Raw: ${data['amazing_products']}');
        debugPrint('Most Seller Products Raw: ${data['most_seller_products']}');
        debugPrint('Newest Products Raw: ${data['newest_products']}');

        final List<SliderModel> sliders =
            (data['sliders'] as List<dynamic>?)
                ?.map((item) => SliderModel.fromJson(item))
                .toList() ??
            [];
        final List<CategoryModel> categories =
            (data['categories'] as List<dynamic>?)
                ?.map((item) => CategoryModel.fromJson(item))
                .toList() ??
            [];
        final List<ProductModel> amazingProducts =
            (data['amazing_products'] as List<dynamic>?)
                ?.map((item) => ProductModel.fromJson(item))
                .toList() ??
            [];
        final List<ProductModel> mostSellerProducts =
            (data['most_seller_products'] as List<dynamic>?)
                ?.map((item) => ProductModel.fromJson(item))
                .toList() ??
            [];
        final List<ProductModel> newestProducts =
            (data['newest_products'] as List<dynamic>?)
                ?.map((item) => ProductModel.fromJson(item))
                .toList() ??
            [];

        debugPrint('Sliders Count: ${sliders.length}');
        debugPrint('Categories Count: ${categories.length}');
        debugPrint('Amazing Products Count: ${amazingProducts.length}');
        debugPrint('Most Seller Products Count: ${mostSellerProducts.length}');
        debugPrint('Newest Products Count: ${newestProducts.length}');

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
        emit(HomeError('Failed to load home data: ${response.statusCode}'));
      }
    } catch (e) {
      debugPrint('Error in getHomeData: $e');
      emit(HomeError('Error loading home data: $e'));
    }
  }
}
