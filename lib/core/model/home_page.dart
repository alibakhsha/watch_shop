class SliderModel {
  final int id;
  final String title;
  final String image;

  SliderModel({required this.id, required this.title, required this.image});

  factory SliderModel.fromJson(Map<String, dynamic> json) {
    return SliderModel(
      id: json['id'],
      title: json['title'],
      image: json['image'],
    );
  }
}

class CategoryModel {
  final int id;
  final String title;
  final String image;

  CategoryModel({required this.id, required this.title, required this.image});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      title: json['title'],
      image: json['image'],
    );
  }
}

class ProductModel {
  final int id;
  final String title;
  final int price;
  final int discount;
  final String specialExpiration;
  final int discountPrice;
  final int productCount;
  final String category;
  final String brand;
  final String image;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.discount,
    required this.specialExpiration,
    required this.discountPrice,
    required this.productCount,
    required this.category,
    required this.brand,
    required this.image,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      discount: json['discount'],
      specialExpiration: json['special_expiration'],
      discountPrice: json['discount_price'],
      productCount: json['product_count'],
      category: json['category'],
      brand: json['brand'],
      image: json['image'],
    );
  }
}
