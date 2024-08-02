import 'package:t_store/features/shop/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    required super.id,
    required super.title,
    required super.price,
    required super.description,
    required super.images,
    required super.category,
    required super.rating,
    required super.brand,
    required super.stock,
    required super.availabilityStatus,
    required super.createdAt,
    required super.discountPercentage,
    required super.returnPolicy,
    required super.reviews,
    required super.shippingInformation,
    required super.tags,
    required super.thumbnail,
    required super.warrantyInformation,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? '',
      title: json['title'] ?? 'No Title',
      price: (json['price'] ?? 0.0).toDouble(),
      description: json['description'] ?? 'No Description',
      images: json['images'] != null
          ? List<String>.from(json['images'])
          : <String>[],
      category: json['category'] ?? 'Uncategorized',
      rating: (json['rating'] ?? 0.0).toDouble(),
      brand: json['brand'] ?? 'No Brand',
      stock: json['stock'] ?? 0,
      availabilityStatus: json['availabilityStatus'] ?? 'Unknown',
      createdAt: json['meta'] != null && json['meta']['createdAt'] != null
          ? DateTime.parse(json['meta']['createdAt'])
          : DateTime.now(),
      discountPercentage: (json['discountPercentage'] ?? 0.0).toDouble(),
      returnPolicy: json['returnPolicy'] ?? 'No Return Policy',
      reviews: json['reviews'] != null
          ? (json['reviews'] as List).map((e) => Review.fromJson(e)).toList()
          : <Review>[],
      shippingInformation:
          json['shippingInformation'] ?? 'No Shipping Information',
      tags: json['tags'] != null ? List<String>.from(json['tags']) : <String>[],
      thumbnail: json['thumbnail'] ?? '',
      warrantyInformation:
          json['warrantyInformation'] ?? 'No Warranty Information',
    );
  }
}

class Review extends ReviewEntity {
  const Review({
    required super.comment,
    required super.date,
    required super.reviewerEmail,
    required super.rating,
    required super.reviewerName,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      rating: (json['rating'] ?? 0),
      comment: json['comment'] ?? 'No Comment',
      date:
          json['date'] != null ? DateTime.parse(json['date']) : DateTime.now(),
      reviewerName: json['reviewerName'] ?? 'Anonymous',
      reviewerEmail: json['reviewerEmail'] ?? 'No Email',
    );
  }
}
