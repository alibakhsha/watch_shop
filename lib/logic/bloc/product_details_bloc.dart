import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watch_shop/logic/event/product_details_event.dart';
import 'package:watch_shop/logic/state/product_details_state.dart';

import '../../core/model/product_details_model.dart';
import '../../services/api_sevice.dart';

class ProductDetailsBloc
    extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  final ApiService apiService;

  ProductDetailsBloc(this.apiService) : super(ProductDetailsInitial()) {
    on<LoadProductDetailsById>(_onLoadProductDetailsById);
  }

  Future<void> _onLoadProductDetailsById(
    LoadProductDetailsById event,
    Emitter<ProductDetailsState> emit,
  ) async {
    emit(ProductDetailsLoading());
    try {
      final response = await apiService.get(
        '/public/api/v1/product_details/${event.id}',
      );
      debugPrint('Product Details Response: ${response.data}');
      final productData = response.data['data'] as List;
      if (productData.isNotEmpty) {
        final productDetails = ProductDetails.fromJson(productData.first);
        emit(ProductDetailsLoaded(productDetails));
      } else {
        emit(ProductDetailsError('محصول یافت نشد'));
      }
    } catch (e) {
      debugPrint('Error loading product details: $e');
      emit(ProductDetailsError('خطا در بارگذاری محصول: $e'));
    }
  }
}
