import 'package:t_store/features/shop/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  const ProductModel(
      {required super.id,
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
      required super.warrantyInformation});
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      price: json['price'].toDouble(),
      description: json['description'],
      images: List<String>.from(json['images']),
      category: json['category'],
      rating: json['rating'] == null ? 0.0 : json['rating'].toDouble(),
      brand: json['brand'],
      stock: json['stock'],
      availabilityStatus: json['availabilityStatus'],
      createdAt: DateTime.parse(json['meta']['createdAt']),
      discountPercentage: json['discountPercentage'].toDouble(),
      returnPolicy: json['returnPolicy'],
      reviews:
          (json['reviews'] as List).map((e) => Review.fromJson(e)).toList(),
      shippingInformation: json['shippingInformation'],
      tags: List<String>.from(json['tags']),
      thumbnail: json['thumbnail'],
      warrantyInformation: json['warrantyInformation'],
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
      rating: json['rating'],
      comment: json['comment'],
      date: DateTime.parse(json['date']),
      reviewerName: json['reviewerName'],
      reviewerEmail: json['reviewerEmail'],
    );
  }
}
