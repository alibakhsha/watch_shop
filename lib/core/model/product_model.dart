import '../../presentation/widgets/product_card.dart';

class ProductModel {
  final int id;
  final String title;
  final double price;
  final double discountPrice;
  final int discount;
  final String category;
  final String brand;
  final String image;
  final int productCount;
  final DateTime? specialExpiration;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.discountPrice,
    required this.discount,
    required this.category,
    required this.brand,
    required this.image,
    required this.productCount,
    this.specialExpiration,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      price: json['price'].toDouble(),
      discountPrice: json['discount_price'].toDouble(),
      discount: json['discount'],
      category: json['category'],
      brand: json['brand'],
      image: json['image'],
      productCount: json['product_count'],
      specialExpiration: json['special_expiration'] != null && json['special_expiration'] != "0000-00-00 00:00:00"
          ? DateTime.parse(json['special_expiration'])
          : null,
    );
  }

  ProductType get productType {
    if (discount > 0 && specialExpiration != null) {
      return ProductType.timedDiscount;
    } else if (discount > 0) {
      return ProductType.discount;
    } else {
      return ProductType.normal;
    }
  }
}
