
abstract class ProductDetailsEvent {}

class LoadProductDetailsById extends ProductDetailsEvent {
  final int id;

  LoadProductDetailsById(this.id);
}