// logic/event/product_event.dart
import 'package:watch_shop/core/enums/product_source.dart';

abstract class ProductEvent {
  const ProductEvent();
}

class FetchProducts extends ProductEvent {
  final ProductSource productSource;
  final int id;

  const FetchProducts(this.productSource, this.id);
}

class FetchProductsByCategory extends ProductEvent {
  final int categoryId;

  const FetchProductsByCategory(this.categoryId);
}

class FetchProductsByBrand extends ProductEvent {
  final int brandId;

  const FetchProductsByBrand(this.brandId);
}