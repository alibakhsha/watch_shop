import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchProductsByCategory extends ProductEvent {
  final int categoryId;
  FetchProductsByCategory(this.categoryId);

  @override
  List<Object?> get props => [categoryId];
}

class FetchProductsByBrand extends ProductEvent {
  final int brandId;
  FetchProductsByBrand(this.brandId);

  @override
  List<Object?> get props => [brandId];
}

class FetchNewestProducts extends ProductEvent {}
