import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:watch_shop/core/model/brand.dart';
import 'package:watch_shop/logic/event/brand_event.dart';
import 'package:watch_shop/logic/state/brand_state.dart';
import '../../services/api_sevice.dart';

class BrandBloc extends Bloc<BrandEvent, BrandState> {
  final ApiService _apiService;

  BrandBloc(this._apiService) : super(BrandInitial()) {
    on<FetchBrands>(_onFetchBrands);
  }

  Future<void> _onFetchBrands(
      FetchBrands event,
      Emitter<BrandState> emit,
      ) async {
    emit(BrandLoading());
    try {
      final response = await _apiService.get('/public/api/v1/brands');
      debugPrint("Brand API Response: ${response.data}");

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['result'] == true) {
          final brandsJson = data['all_brands'] as List;
          final brands = brandsJson.map((json) => BrandModel.fromJson(json)).toList();
          emit(BrandLoaded(brands));
        } else {
          emit(BrandError(data['message']));
        }
      } else {
        emit(BrandError('خطا در دریافت داده‌ها: ${response.statusCode}'));
      }
    } catch (e) {
      emit(BrandError('خطای شبکه: $e'));
    }
  }
}