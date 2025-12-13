import 'package:equatable/equatable.dart';
import 'package:t_store/features/reviews/domain/entities/review_entity.dart';

abstract class ReviewsState extends Equatable {
  const ReviewsState();

  @override
  List<Object?> get props => [];
}

class ReviewsInitial extends ReviewsState {}

class ReviewsLoading extends ReviewsState {}

class ReviewsLoaded extends ReviewsState {
  final List<ReviewEntity> reviews;
  final ProductReviewStats? stats;
  final bool hasReachedMax;
  final int currentPage;

  const ReviewsLoaded({
    required this.reviews,
    this.stats,
    this.hasReachedMax = false,
    this.currentPage = 0,
  });

  @override
  List<Object?> get props => [reviews, stats, hasReachedMax, currentPage];

  ReviewsLoaded copyWith({
    List<ReviewEntity>? reviews,
    ProductReviewStats? stats,
    bool? hasReachedMax,
    int? currentPage,
  }) {
    return ReviewsLoaded(
      reviews: reviews ?? this.reviews,
      stats: stats ?? this.stats,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}

class ReviewsError extends ReviewsState {
  final String message;

  const ReviewsError(this.message);

  @override
  List<Object?> get props => [message];
}

class ReviewAdding extends ReviewsState {}

class ReviewAdded extends ReviewsState {
  final ReviewEntity review;

  const ReviewAdded(this.review);

  @override
  List<Object?> get props => [review];
}
