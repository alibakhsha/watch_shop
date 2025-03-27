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
