import 'package:flutter/cupertino.dart';
import 'package:watch_shop/core/enums/product_source.dart';
import 'package:watch_shop/core/model/products_model.dart';
import 'package:watch_shop/logic/event/product_event.dart';
import 'package:watch_shop/logic/state/product_state.dart';
import 'package:bloc/bloc.dart';
import '../../services/api_sevice.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ApiService _apiService;

  ProductBloc([ApiService? apiService])
      : _apiService = apiService ?? ApiService(),
        super(ProductInitial()) {
    on<FetchProducts>(_onFetchProducts);
    on<FetchProductsByCategory>(_onFetchProductsByCategory);
    on<FetchProductsByBrand>(_onFetchProductsByBrand);
    on<FetchProductsBySearch>(_onFetchProductsBySearch); // اضافه کردن
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
        case ProductSource.search:
          emit(ProductError('برای جستجو از FetchProductsBySearch استفاده کنید'));
          return;
      }

      final response = await _apiService.get(path);

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['result'] == true) {
          final productsJson =
          event.productSource == ProductSource.category ||
              event.productSource == ProductSource.brand
              ? data['products_by_category']['data']
              : data['data'];
          final products = (productsJson as List)
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
          final productsJson = data['products_by_brands']['data'] as List;
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

  Future<void> _onFetchProductsBySearch(
      FetchProductsBySearch event,
      Emitter<ProductState> emit,
      ) async {
    emit(ProductLoading());
    debugPrint('Fetching products for search query: ${event.searchQuery}');
    try {
      final encodedQuery = Uri.encodeComponent(event.searchQuery);
      debugPrint('Encoded Search Query: $encodedQuery');
      // ارسال به صورت مسیر URL
      final response = await _apiService.get(
        '/public/api/v1/all_products/$encodedQuery',
      );
      debugPrint("Search Response Status: ${response.statusCode}");
      debugPrint("Search Response Data: ${response.data}");

      if (response.statusCode == 200) {
        final data = response.data;
        debugPrint("Search Result: ${data['result']}");
        final productsJson = data['all_products']?['data'] as List?;
        debugPrint("Search Products JSON: $productsJson");

        if (productsJson != null && productsJson.isNotEmpty) {
          final products =
          productsJson.map((json) => ProductsModel.fromJson(json)).toList();
          debugPrint("Parsed Search Products: $products");
          emit(ProductLoaded(products));
        } else {
          debugPrint("No products found for query: ${event.searchQuery}");
          emit(ProductError('هیچ محصولی برای "${event.searchQuery}" یافت نشد'));
        }
      } else {
        debugPrint("Search Failed with Status: ${response.statusCode}");
        emit(ProductError('خطا در دریافت داده‌ها: ${response.statusCode}'));
      }
    } catch (e) {
      debugPrint("Search Error: $e");
      emit(ProductError('خطای شبکه: $e'));
    }
  }
}