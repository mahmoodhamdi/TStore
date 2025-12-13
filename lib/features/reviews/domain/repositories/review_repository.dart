import 'package:dartz/dartz.dart';
import 'package:t_store/features/reviews/domain/entities/review_entity.dart';

abstract class ReviewRepository {
  Future<Either<String, List<ReviewEntity>>> getProductReviews(
    String productId, {
    int page = 0,
    int limit = 20,
  });

  Future<Either<String, ReviewEntity>> addReview({
    required String productId,
    required int rating,
    String? title,
    String? comment,
    List<String>? images,
  });

  Future<Either<String, ReviewEntity>> updateReview({
    required String reviewId,
    required int rating,
    String? title,
    String? comment,
    List<String>? images,
  });

  Future<Either<String, void>> deleteReview(String reviewId);

  Future<Either<String, ProductReviewStats>> getProductReviewStats(
      String productId);

  Future<Either<String, bool>> hasUserReviewed(String productId);
}
