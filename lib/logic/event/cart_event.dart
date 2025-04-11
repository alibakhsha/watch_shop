import 'package:equatable/equatable.dart';

abstract class CartEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadCart extends CartEvent {}

class AddProductToCart extends CartEvent {
  final int productId;
  final int quantity;

  AddProductToCart({required this.productId, this.quantity = 1});

  @override
  List<Object?> get props => [productId, quantity];
}

class IncreaseCartItemQuantity extends CartEvent {
  final int productId;

  IncreaseCartItemQuantity(this.productId);

  @override
  List<Object?> get props => [productId];
}

class DecreaseCartItemQuantity extends CartEvent {
  final int productId;

  DecreaseCartItemQuantity(this.productId);

  @override
  List<Object?> get props => [productId];
}

class DeleteCartItem extends CartEvent {
  final int productId;

  DeleteCartItem(this.productId);

  @override
  List<Object?> get props => [productId];
}
