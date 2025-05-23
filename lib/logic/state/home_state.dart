import 'package:equatable/equatable.dart';

import '../../core/model/home_page.dart';
import '../../core/model/products_model.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}
class HomeLoading extends HomeState {}
class HomeLoaded extends HomeState {
  final List<SliderModel> sliders;
  final List<CategoryModel> categories;
  final List<ProductsModel> amazingProducts;
  final List<ProductsModel> mostSellerProducts;
  final List<ProductsModel> newestProducts;

  HomeLoaded({
    required this.sliders,
    required this.categories,
    required this.amazingProducts,
    required this.mostSellerProducts,
    required this.newestProducts,
  });

  @override
  List<Object> get props => [sliders, categories, amazingProducts, mostSellerProducts, newestProducts];
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}
