// lib/logic/event/product_event.dart
import '../../core/enums/product_source.dart';

abstract class ProductEvent {}

class FetchProducts extends ProductEvent {
  final ProductSource productSource;
  final int id;

  FetchProducts(this.productSource, this.id);
}

class FetchProductsByCategory extends ProductEvent {
  final int categoryId;

  FetchProductsByCategory(this.categoryId);
}

class FetchProductsByBrand extends ProductEvent {
  final int brandId;

  FetchProductsByBrand(this.brandId);
}

class FetchProductsBySearch extends ProductEvent {
  final String searchQuery;

  FetchProductsBySearch(this.searchQuery);
}