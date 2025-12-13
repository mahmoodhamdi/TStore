import 'package:t_store/features/shop/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    required super.id,
    required super.name,
    super.description,
    required super.price,
    super.salePrice,
    required super.categoryId,
    super.brandId,
    required super.stock,
    required super.images,
    super.thumbnail,
    super.rating,
    super.reviewsCount,
    super.isFeatured,
    super.isActive,
    super.attributes,
    super.createdAt,
    super.updatedAt,
    super.categoryName,
    super.brandName,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      price: (json['price'] as num).toDouble(),
      salePrice: json['sale_price'] != null
          ? (json['sale_price'] as num).toDouble()
          : null,
      categoryId: json['category_id'] as String,
      brandId: json['brand_id'] as String?,
      stock: json['stock'] as int? ?? 0,
      images: json['images'] != null
          ? List<String>.from(json['images'] as List)
          : <String>[],
      thumbnail: json['thumbnail'] as String?,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      reviewsCount: json['reviews_count'] as int? ?? 0,
      isFeatured: json['is_featured'] as bool? ?? false,
      isActive: json['is_active'] as bool? ?? true,
      attributes: json['attributes'] as Map<String, dynamic>?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
      // Joined data from relations
      categoryName: json['categories'] != null
          ? (json['categories'] as Map<String, dynamic>)['name'] as String?
          : null,
      brandName: json['brands'] != null
          ? (json['brands'] as Map<String, dynamic>)['name'] as String?
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'sale_price': salePrice,
      'category_id': categoryId,
      'brand_id': brandId,
      'stock': stock,
      'images': images,
      'thumbnail': thumbnail,
      'rating': rating,
      'reviews_count': reviewsCount,
      'is_featured': isFeatured,
      'is_active': isActive,
      'attributes': attributes,
    };
  }

  factory ProductModel.fromEntity(ProductEntity entity) {
    return ProductModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      price: entity.price,
      salePrice: entity.salePrice,
      categoryId: entity.categoryId,
      brandId: entity.brandId,
      stock: entity.stock,
      images: entity.images,
      thumbnail: entity.thumbnail,
      rating: entity.rating,
      reviewsCount: entity.reviewsCount,
      isFeatured: entity.isFeatured,
      isActive: entity.isActive,
      attributes: entity.attributes,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      categoryName: entity.categoryName,
      brandName: entity.brandName,
    );
  }
}
