import 'package:dartz/dartz.dart';
import 'package:t_store/core/usecases/usecase.dart';
import 'package:t_store/features/reviews/domain/entities/review_entity.dart';
import 'package:t_store/features/reviews/domain/repositories/review_repository.dart';

class GetProductReviewsUsecase
    implements UseCase<List<ReviewEntity>, GetProductReviewsParams> {
  final ReviewRepository repository;

  GetProductReviewsUsecase(this.repository);

  @override
  Future<Either<String, List<ReviewEntity>>> call(
      GetProductReviewsParams params) async {
    return await repository.getProductReviews(
      params.productId,
      page: params.page,
      limit: params.limit,
    );
  }
}

class GetProductReviewsParams {
  final String productId;
  final int page;
  final int limit;

  GetProductReviewsParams({
    required this.productId,
    this.page = 0,
    this.limit = 20,
  });
}
