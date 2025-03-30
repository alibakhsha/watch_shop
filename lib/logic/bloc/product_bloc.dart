import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../core/model/product_model.dart';
import '../../services/api_sevice.dart';
import '../event/product_event.dart';
import '../state/product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ApiService _apiService;

  ProductBloc(this._apiService) : super(ProductInitial()) {
    on<FetchProductsByCategory>(_onFetchProductsByCategory);
    on<FetchProductsByBrand>(_onFetchProductsByBrand);
    on<FetchNewestProducts>(_onFetchNewestProducts);
  }

  void _onFetchProductsByCategory(
      FetchProductsByCategory event,
      Emitter<ProductState> emit,
      ) async {
    emit(ProductLoading());
    try {
      final response = await _apiService.get(
        '/public/api/v1/products_by_category/${event.categoryId}',
      );

      final data = response.data;
      if (data != null && data['products_by_category'] != null) {
        final List<dynamic> rawProducts = data['products_by_category']['data'];

        List<ProductModel> products = rawProducts
            .map((json) => ProductModel.fromJson(json))
            .toList();

        emit(ProductLoaded(products));
      } else {
        emit(ProductError("No products found"));
      }

    } catch (e) {
      emit(ProductError('Failed to load products: ${e.toString()}'));
    }
  }

  void _onFetchProductsByBrand(
    FetchProductsByBrand event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    try {
      final response = await _apiService.get(
        '/public/api/v1/products_by_brand/${event.brandId}',
      );
      List<ProductModel> products =
          (response.data as List)
              .map((json) => ProductModel.fromJson(json))
              .toList();
      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError('Failed to load products: ${e.toString()}'));
    }
  }

  void _onFetchNewestProducts(
    FetchNewestProducts event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    try {
      final response = await _apiService.get('/public/api/v1/newest_products');
      List<ProductModel> products =
          (response.data as List)
              .map((json) => ProductModel.fromJson(json))
              .toList();
      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError('Failed to load products: ${e.toString()}'));
    }
  }
}
