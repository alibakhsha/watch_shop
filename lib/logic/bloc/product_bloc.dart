import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:watch_shop/core/enums/product_source.dart';
import 'package:watch_shop/core/model/products_model.dart';
import 'package:watch_shop/logic/event/product_event.dart';
import 'package:watch_shop/logic/state/product_state.dart';

import '../../services/api_sevice.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ApiService _apiService;

  ProductBloc([ApiService? apiService])
    : _apiService = apiService ?? ApiService(),
      super(ProductInitial()) {
    on<FetchProducts>(_onFetchProducts);
    on<FetchProductsByCategory>(_onFetchProductsByCategory);
    on<FetchProductsByBrand>(_onFetchProductsByBrand);
  }

  Future<void> _onFetchProducts(
    FetchProducts event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    try {
      String path;
      switch (event.productSource) {
        case ProductSource.amazing:
          path = '/public/api/v1/amazing_products';
          break;
        case ProductSource.newest:
          path = '/public/api/v1/newest_products';
          break;
        case ProductSource.cheapest:
          path = '/public/api/v1/cheapest_products';
          break;
        case ProductSource.mostExpensive:
          path = '/public/api/v1/most_expensive_products';
          break;
        case ProductSource.mostViewed:
          path = '/public/api/v1/most_viewed_products';
          break;
        case ProductSource.category:
          path = '/public/api/v1/products_by_category/${event.id}';
          break;
        case ProductSource.brand:
          path = '/public/api/v1/products_by_brand/${event.id}';
          break;
      }

      final response = await _apiService.get(path);

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['result'] == true) {
          final productsJson =
              event.productSource == ProductSource.category ||
                      event.productSource == ProductSource.brand
                  ? data['products_by_category']['data'] // یا products_by_brand
                  : data['data'];
          final products =
              (productsJson as List)
                  .map((json) => ProductsModel.fromJson(json))
                  .toList();
          emit(ProductLoaded(products));
        } else {
          emit(ProductError(data['message']));
        }
      } else {
        emit(ProductError('خطا در دریافت داده‌ها: ${response.statusCode}'));
      }
    } catch (e) {
      emit(ProductError('خطای شبکه: $e'));
    }
  }

  Future<void> _onFetchProductsByCategory(
    FetchProductsByCategory event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    try {
      final response = await _apiService.get(
        '/public/api/v1/products_by_category/${event.categoryId}',
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['result'] == true) {
          final productsJson = data['products_by_category']['data'] as List;
          final products =
              productsJson.map((json) => ProductsModel.fromJson(json)).toList();
          emit(ProductLoaded(products));
        } else {
          emit(ProductError(data['message']));
        }
      } else {
        emit(ProductError('خطا در دریافت داده‌ها: ${response.statusCode}'));
      }
    } catch (e) {
      emit(ProductError('خطای شبکه: $e'));
    }
  }

  // logic/bloc/product_bloc.dart (بخشی از کد)
  Future<void> _onFetchProductsByBrand(
    FetchProductsByBrand event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    try {
      final response = await _apiService.get(
        '/public/api/v1/products_by_brand/${event.brandId}',
      );
      debugPrint("Response for brand ${event.brandId}: ${response.data}");

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['result'] == true) {
          final productsJson =
              data['products_by_brands']['data'] as List; // اصلاح کلید
          debugPrint("Products JSON: $productsJson");
          final products =
              productsJson.map((json) => ProductsModel.fromJson(json)).toList();
          debugPrint("Parsed Products: $products");
          emit(ProductLoaded(products));
        } else {
          emit(ProductError(data['message']));
        }
      } else {
        emit(ProductError('خطا در دریافت داده‌ها: ${response.statusCode}'));
      }
    } catch (e) {
      emit(ProductError('خطای شبکه: $e'));
    }
  }
}
