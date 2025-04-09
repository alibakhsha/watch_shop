class BrandModel {
  final int id;
  final String title;
  final String image;

  const BrandModel({
    required this.id,
    required this.title,
    required this.image,
  });

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
      id: json['id'],
      title: json['title'],
      image: json['image'],
    );
  }
}
