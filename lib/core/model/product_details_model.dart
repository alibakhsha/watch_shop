// lib/core/model/product_details.dart
class ProductDetails {
  final int id;
  final String title;
  final String titleEn;
  final double price;
  final int discount;
  final double discountPrice;
  final String guaranty;
  final int productCount;
  final String category;
  final int categoryId;
  final List<ProductColor> colors;
  final String brand;
  final int brandId;
  final int review;
  final String image;
  final List<ProductProperty> properties;
  final String description;
  final String discussion;
  final List<Comment> comments;

  ProductDetails({
    required this.id,
    required this.title,
    required this.titleEn,
    required this.price,
    required this.discount,
    required this.discountPrice,
    required this.guaranty,
    required this.productCount,
    required this.category,
    required this.categoryId,
    required this.colors,
    required this.brand,
    required this.brandId,
    required this.review,
    required this.image,
    required this.properties,
    required this.description,
    required this.discussion,
    required this.comments,
  });

  factory ProductDetails.fromJson(Map<String, dynamic> json) {
    return ProductDetails(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      titleEn: json['title_en'] ?? '',
      price: (json['price'] ?? 0.0).toDouble(),
      discount: json['discount'] ?? 0,
      discountPrice: (json['discount_price'] ?? 0.0).toDouble(),
      guaranty: json['guaranty'] ?? '',
      productCount: json['product_count'] ?? 0,
      category: json['category'] ?? '',
      categoryId: json['category_id'] ?? 0,
      colors: (json['colors'] as List? ?? [])
          .map((color) => ProductColor.fromJson(color))
          .toList(),
      brand: json['brand'] ?? '',
      brandId: json['brand_id'] ?? 0,
      review: json['review'] ?? 0,
      image: json['image'] ?? '',
      properties: (json['properties'] as List? ?? [])
          .map((prop) => ProductProperty.fromJson(prop))
          .toList(),
      description: json['description'] ?? '',
      discussion: json['discussion'] ?? '',
      comments: (json['comments'] as List? ?? [])
          .map((comment) => Comment.fromJson(comment))
          .toList(),
    );
  }

  @override
  String toString() {
    return 'ProductDetails(id: $id, title: $title, price: $price)';
  }
}

class ProductColor {
  final String title;
  final String code;

  ProductColor({required this.title, required this.code});

  factory ProductColor.fromJson(Map<String, dynamic> json) {
    return ProductColor(
      title: json['title'] ?? '',
      code: json['code'] ?? '',
    );
  }
}

class ProductProperty {
  final String property;
  final String value;

  ProductProperty({required this.property, required this.value});

  factory ProductProperty.fromJson(Map<String, dynamic> json) {
    return ProductProperty(
      property: json['property'] ?? '',
      value: json['value'] ?? '',
    );
  }
}

class Comment {
  final String user;
  final String body;

  Comment({required this.user, required this.body});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      user: json['user'] ?? '',
      body: json['body'] ?? '',
    );
  }
}