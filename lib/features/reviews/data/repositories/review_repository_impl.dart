import 'package:dartz/dartz.dart';
import 'package:t_store/core/supabase/supabase_service.dart';
import 'package:t_store/core/supabase/supabase_tables.dart';
import 'package:t_store/features/reviews/data/models/review_model.dart';
import 'package:t_store/features/reviews/domain/entities/review_entity.dart';
import 'package:t_store/features/reviews/domain/repositories/review_repository.dart';

class ReviewRepositoryImpl implements ReviewRepository {
  final SupabaseService supabaseService;

  ReviewRepositoryImpl({required this.supabaseService});

  String get _userId => supabaseService.currentUser?.id ?? '';

  @override
  Future<Either<String, List<ReviewEntity>>> getProductReviews(
    String productId, {
    int page = 0,
    int limit = 20,
  }) async {
    try {
      final from = page * limit;
      final to = from + limit - 1;

      final response = await supabaseService.client
          .from(SupabaseTables.reviews)
          .select('*, profiles(full_name, avatar_url)')
          .eq('product_id', productId)
          .order('created_at', ascending: false)
          .range(from, to);

      final reviews = (response as List)
          .map((json) => ReviewModel.fromJson(json as Map<String, dynamic>))
          .toList();

      return Right(reviews);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, ReviewEntity>> addReview({
    required String productId,
    required int rating,
    String? title,
    String? comment,
    List<String>? images,
  }) async {
    try {
      if (_userId.isEmpty) {
        return const Left('يرجى تسجيل الدخول أولاً');
      }

      // Check if user already reviewed
      final existing = await supabaseService.client
          .from(SupabaseTables.reviews)
          .select('id')
          .eq('user_id', _userId)
          .eq('product_id', productId)
          .maybeSingle();

      if (existing != null) {
        return const Left('لقد قمت بتقييم هذا المنتج مسبقاً');
      }

      // Check if user has purchased this product
      final hasPurchased = await _checkVerifiedPurchase(productId);

      final response = await supabaseService.client
          .from(SupabaseTables.reviews)
          .insert({
            'user_id': _userId,
            'product_id': productId,
            'rating': rating,
            'title': title,
            'comment': comment,
            'images': images,
            'is_verified_purchase': hasPurchased,
          })
          .select('*, profiles(full_name, avatar_url)')
          .single();

      return Right(ReviewModel.fromJson(response));
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, ReviewEntity>> updateReview({
    required String reviewId,
    required int rating,
    String? title,
    String? comment,
    List<String>? images,
  }) async {
    try {
      final response = await supabaseService.client
          .from(SupabaseTables.reviews)
          .update({
            'rating': rating,
            'title': title,
            'comment': comment,
            'images': images,
          })
          .eq('id', reviewId)
          .eq('user_id', _userId) // Ensure user owns the review
          .select('*, profiles(full_name, avatar_url)')
          .single();

      return Right(ReviewModel.fromJson(response));
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> deleteReview(String reviewId) async {
    try {
      await supabaseService.client
          .from(SupabaseTables.reviews)
          .delete()
          .eq('id', reviewId)
          .eq('user_id', _userId);

      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, ProductReviewStats>> getProductReviewStats(
      String productId) async {
    try {
      final response = await supabaseService.client
          .from(SupabaseTables.reviews)
          .select('rating')
          .eq('product_id', productId);

      final ratings = (response as List).map((e) => e['rating'] as int).toList();

      if (ratings.isEmpty) {
        return const Right(ProductReviewStats(
          averageRating: 0,
          totalReviews: 0,
          ratingDistribution: {1: 0, 2: 0, 3: 0, 4: 0, 5: 0},
        ));
      }

      final average = ratings.reduce((a, b) => a + b) / ratings.length;
      final distribution = <int, int>{1: 0, 2: 0, 3: 0, 4: 0, 5: 0};
      for (final rating in ratings) {
        distribution[rating] = (distribution[rating] ?? 0) + 1;
      }

      return Right(ProductReviewStats(
        averageRating: average,
        totalReviews: ratings.length,
        ratingDistribution: distribution,
      ));
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, bool>> hasUserReviewed(String productId) async {
    try {
      if (_userId.isEmpty) {
        return const Right(false);
      }

      final response = await supabaseService.client
          .from(SupabaseTables.reviews)
          .select('id')
          .eq('user_id', _userId)
          .eq('product_id', productId)
          .maybeSingle();

      return Right(response != null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<bool> _checkVerifiedPurchase(String productId) async {
    try {
      final response = await supabaseService.client
          .from(SupabaseTables.orderItems)
          .select('id, orders!inner(user_id, status)')
          .eq('product_id', productId)
          .eq('orders.user_id', _userId)
          .eq('orders.status', 'delivered')
          .limit(1);

      return (response as List).isNotEmpty;
    } catch (_) {
      return false;
    }
  }
}
