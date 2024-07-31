import 'package:t_store/features/shop/domain/entities/category_entity.dart';

class CategoryModel extends CategoryEntity {
  const CategoryModel(
      {required super.id, required super.name, required super.image});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }
}
