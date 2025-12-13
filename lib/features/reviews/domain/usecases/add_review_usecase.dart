import 'package:dartz/dartz.dart';
import 'package:t_store/core/usecases/usecase.dart';
import 'package:t_store/features/reviews/domain/entities/review_entity.dart';
import 'package:t_store/features/reviews/domain/repositories/review_repository.dart';

class AddReviewUsecase implements UseCase<ReviewEntity, AddReviewParams> {
  final ReviewRepository repository;

  AddReviewUsecase(this.repository);

  @override
  Future<Either<String, ReviewEntity>> call(AddReviewParams params) async {
    return await repository.addReview(
      productId: params.productId,
      rating: params.rating,
      title: params.title,
      comment: params.comment,
      images: params.images,
    );
  }
}

class AddReviewParams {
  final String productId;
  final int rating;
  final String? title;
  final String? comment;
  final List<String>? images;

  AddReviewParams({
    required this.productId,
    required this.rating,
    this.title,
    this.comment,
    this.images,
  });
}
