import 'package:t_store/features/shop/data/models/category_model.dart';
import 'package:t_store/features/shop/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  const ProductModel(
      {required super.id,
      required super.title,
      required super.price,
      required super.description,
      required super.images,
      required super.category});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        id: json['id'],
        title: json['title'],
        price: json['price'],
        description: json['description'],
        images:List<String>.from (json['images']),
        category: CategoryModel.fromJson(json['category']));
  }
}
