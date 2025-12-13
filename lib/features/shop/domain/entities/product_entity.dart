import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String id;
  final String name;
  final String? description;
  final double price;
  final double? salePrice;
  final String categoryId;
  final String? brandId;
  final int stock;
  final List<String> images;
  final String? thumbnail;
  final double rating;
  final int reviewsCount;
  final bool isFeatured;
  final bool isActive;
  final Map<String, dynamic>? attributes;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  // Joined data
  final String? categoryName;
  final String? brandName;

  const ProductEntity({
    required this.id,
    required this.name,
    this.description,
    required this.price,
    this.salePrice,
    required this.categoryId,
    this.brandId,
    required this.stock,
    required this.images,
    this.thumbnail,
    this.rating = 0.0,
    this.reviewsCount = 0,
    this.isFeatured = false,
    this.isActive = true,
    this.attributes,
    this.createdAt,
    this.updatedAt,
    this.categoryName,
    this.brandName,
  });

  double get discountPercentage {
    if (salePrice == null || salePrice! >= price) return 0;
    return ((price - salePrice!) / price) * 100;
  }

  bool get hasDiscount => salePrice != null && salePrice! < price;

  double get effectivePrice => salePrice ?? price;

  bool get isInStock => stock > 0;

  String get availabilityStatus {
    if (stock <= 0) return 'غير متوفر';
    if (stock <= 5) return 'كمية محدودة';
    return 'متوفر';
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        price,
        salePrice,
        categoryId,
        brandId,
        stock,
        images,
        thumbnail,
        rating,
        reviewsCount,
        isFeatured,
        isActive,
        attributes,
        createdAt,
        updatedAt,
      ];

  ProductEntity copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    double? salePrice,
    String? categoryId,
    String? brandId,
    int? stock,
    List<String>? images,
    String? thumbnail,
    double? rating,
    int? reviewsCount,
    bool? isFeatured,
    bool? isActive,
    Map<String, dynamic>? attributes,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? categoryName,
    String? brandName,
  }) {
    return ProductEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      salePrice: salePrice ?? this.salePrice,
      categoryId: categoryId ?? this.categoryId,
      brandId: brandId ?? this.brandId,
      stock: stock ?? this.stock,
      images: images ?? this.images,
      thumbnail: thumbnail ?? this.thumbnail,
      rating: rating ?? this.rating,
      reviewsCount: reviewsCount ?? this.reviewsCount,
      isFeatured: isFeatured ?? this.isFeatured,
      isActive: isActive ?? this.isActive,
      attributes: attributes ?? this.attributes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      categoryName: categoryName ?? this.categoryName,
      brandName: brandName ?? this.brandName,
    );
  }
}
