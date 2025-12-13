import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/features/reviews/domain/entities/review_entity.dart';
import 'package:t_store/features/reviews/domain/usecases/get_product_reviews_usecase.dart';
import 'package:t_store/features/reviews/domain/usecases/add_review_usecase.dart';
import 'package:t_store/features/reviews/presentation/cubit/reviews_state.dart';

class ReviewsCubit extends Cubit<ReviewsState> {
  final GetProductReviewsUsecase getProductReviewsUsecase;
  final AddReviewUsecase addReviewUsecase;

  ReviewsCubit({
    required this.getProductReviewsUsecase,
    required this.addReviewUsecase,
  }) : super(ReviewsInitial());

  List<ReviewEntity> _allReviews = [];
  int _currentPage = 0;
  static const int _limit = 20;

  Future<void> getProductReviews(String productId, {bool refresh = false}) async {
    if (refresh) {
      _currentPage = 0;
      _allReviews = [];
    }

    if (_currentPage == 0) {
      emit(ReviewsLoading());
    }

    final result = await getProductReviewsUsecase(GetProductReviewsParams(
      productId: productId,
      page: _currentPage,
      limit: _limit,
    ));

    result.fold(
      (error) => emit(ReviewsError(error)),
      (reviews) {
        _allReviews = [..._allReviews, ...reviews];
        _currentPage++;
        emit(ReviewsLoaded(
          reviews: _allReviews,
          hasReachedMax: reviews.length < _limit,
          currentPage: _currentPage,
        ));
      },
    );
  }

  Future<void> loadMoreReviews(String productId) async {
    if (state is ReviewsLoaded) {
      final currentState = state as ReviewsLoaded;
      if (currentState.hasReachedMax) return;
      await getProductReviews(productId);
    }
  }

  Future<void> addReview({
    required String productId,
    required int rating,
    String? title,
    String? comment,
    List<String>? images,
  }) async {
    emit(ReviewAdding());

    final result = await addReviewUsecase(AddReviewParams(
      productId: productId,
      rating: rating,
      title: title,
      comment: comment,
      images: images,
    ));

    result.fold(
      (error) => emit(ReviewsError(error)),
      (review) {
        emit(ReviewAdded(review));
        getProductReviews(productId, refresh: true);
      },
    );
  }

  void resetReviews() {
    _currentPage = 0;
    _allReviews = [];
    emit(ReviewsInitial());
  }
}
