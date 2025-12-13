import 'package:equatable/equatable.dart';

class ReviewEntity extends Equatable {
  final String id;
  final String userId;
  final String productId;
  final int rating;
  final String? title;
  final String? comment;
  final List<String>? images;
  final bool isVerifiedPurchase;
  final int helpfulCount;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  // Joined data
  final String? userName;
  final String? userAvatar;

  const ReviewEntity({
    required this.id,
    required this.userId,
    required this.productId,
    required this.rating,
    this.title,
    this.comment,
    this.images,
    this.isVerifiedPurchase = false,
    this.helpfulCount = 0,
    this.createdAt,
    this.updatedAt,
    this.userName,
    this.userAvatar,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        productId,
        rating,
        title,
        comment,
        images,
        isVerifiedPurchase,
        helpfulCount,
        createdAt,
        updatedAt,
      ];

  ReviewEntity copyWith({
    String? id,
    String? userId,
    String? productId,
    int? rating,
    String? title,
    String? comment,
    List<String>? images,
    bool? isVerifiedPurchase,
    int? helpfulCount,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? userName,
    String? userAvatar,
  }) {
    return ReviewEntity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      productId: productId ?? this.productId,
      rating: rating ?? this.rating,
      title: title ?? this.title,
      comment: comment ?? this.comment,
      images: images ?? this.images,
      isVerifiedPurchase: isVerifiedPurchase ?? this.isVerifiedPurchase,
      helpfulCount: helpfulCount ?? this.helpfulCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      userName: userName ?? this.userName,
      userAvatar: userAvatar ?? this.userAvatar,
    );
  }
}

class ProductReviewStats extends Equatable {
  final double averageRating;
  final int totalReviews;
  final Map<int, int> ratingDistribution;

  const ProductReviewStats({
    required this.averageRating,
    required this.totalReviews,
    required this.ratingDistribution,
  });

  int get fiveStarCount => ratingDistribution[5] ?? 0;
  int get fourStarCount => ratingDistribution[4] ?? 0;
  int get threeStarCount => ratingDistribution[3] ?? 0;
  int get twoStarCount => ratingDistribution[2] ?? 0;
  int get oneStarCount => ratingDistribution[1] ?? 0;

  double getPercentage(int stars) {
    if (totalReviews == 0) return 0;
    return (ratingDistribution[stars] ?? 0) / totalReviews * 100;
  }

  @override
  List<Object?> get props => [averageRating, totalReviews, ratingDistribution];
}
