import 'package:equatable/equatable.dart';

class CartModel extends Equatable {
  final List<CartItem> items;
  final double totalPrice;
  final double totalWithDiscountPrice;

  const CartModel({
    required this.items,
    required this.totalPrice,
    required this.totalWithDiscountPrice,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    final userCart = json['data']['user_cart'];
    return CartModel(
      items:
          (userCart as List?)
              ?.map((item) => CartItem.fromJson(item))
              .toList() ??
          [],
      totalPrice: (json['data']['cart_total_price'] as num?)?.toDouble() ?? 0.0,
      totalWithDiscountPrice:
          (json['data']['total_without_discount_price'] as num?)?.toDouble() ??
          0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': {
        'user_cart': items.map((item) => item.toJson()).toList(),
        'cart_total_price': totalPrice,
        'total_without_discount_price': totalWithDiscountPrice,
      },
    };
  }

  @override
  List<Object?> get props => [items, totalPrice, totalWithDiscountPrice];
}

class CartItem extends Equatable {
  final int id;
  final int productId;
  final String productTitle;
  final int quantity;
  final String image;
  final double price;
  final double priceDiscount;

  const CartItem({
    required this.id,
    required this.productId,
    required this.productTitle,
    required this.quantity,
    required this.image,
    required this.price,
    required this.priceDiscount,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      productId: json['product_id'],
      productTitle: json['product'] ?? 'محصول بدون نام',
      quantity: json['count'],
      image: json['image'] ?? 'https://via.placeholder.com/150',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      priceDiscount: (json['discount_price'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'product': productTitle,
      'count': quantity,
      'image': image,
      'price': price,
      'discount_price': priceDiscount,
    };
  }

  @override
  List<Object?> get props => [
    id,
    productId,
    productTitle,
    quantity,
    image,
    price,
    priceDiscount,
  ];
}
