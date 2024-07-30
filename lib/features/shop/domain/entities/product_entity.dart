import 'package:equatable/equatable.dart';
import 'package:t_store/features/shop/domain/entities/category_entity.dart';

class ProductEntity extends Equatable {
  final int id;
  final String title;
  final String description;
  final num price;
  final List<String> images;
  final CategoryEntity category;

  const ProductEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.images,
    required this.category,
  });
  @override
  List<Object?> get props => [id, title, description, price, images, category];
}
