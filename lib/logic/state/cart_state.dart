import 'package:equatable/equatable.dart';
import 'package:watch_shop/core/model/cart.dart';

abstract class CartState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<CartItem> cartItems;
  final double totalPrice;

  CartLoaded({required this.cartItems, required this.totalPrice});

  @override
  List<Object?> get props => [cartItems, totalPrice];
}

class CartError extends CartState {
  final String message;

  CartError({required this.message});

  @override
  List<Object?> get props => [message];
}
