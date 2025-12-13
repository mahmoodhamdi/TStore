import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:t_store/features/reviews/domain/entities/review_entity.dart';
import 'package:t_store/features/reviews/domain/usecases/get_product_reviews_usecase.dart';
import 'package:t_store/features/reviews/domain/usecases/add_review_usecase.dart';
import 'package:t_store/features/reviews/presentation/cubit/reviews_cubit.dart';
import 'package:t_store/features/reviews/presentation/cubit/reviews_state.dart';

// Mocks
class MockGetProductReviewsUsecase extends Mock
    implements GetProductReviewsUsecase {}

class MockAddReviewUsecase extends Mock implements AddReviewUsecase {}

// Fakes
class FakeGetProductReviewsParams extends Fake
    implements GetProductReviewsParams {}

class FakeAddReviewParams extends Fake implements AddReviewParams {}

void main() {
  late ReviewsCubit reviewsCubit;
  late MockGetProductReviewsUsecase mockGetProductReviewsUsecase;
  late MockAddReviewUsecase mockAddReviewUsecase;

  // Test data
  const testProductId = 'product-1';

  final testReviews = [
    ReviewEntity(
      id: 'review-1',
      userId: 'user-1',
      productId: testProductId,
      rating: 5,
      title: 'Great product!',
      comment: 'Highly recommend',
      isVerifiedPurchase: true,
      helpfulCount: 10,
      userName: 'John Doe',
      createdAt: DateTime(2024, 1, 15),
    ),
    ReviewEntity(
      id: 'review-2',
      userId: 'user-2',
      productId: testProductId,
      rating: 4,
      title: 'Good quality',
      comment: 'Worth the price',
      isVerifiedPurchase: false,
      helpfulCount: 5,
      userName: 'Jane Smith',
      createdAt: DateTime(2024, 1, 10),
    ),
  ];

  final newReview = ReviewEntity(
    id: 'review-3',
    userId: 'user-3',
    productId: testProductId,
    rating: 5,
    title: 'Amazing!',
    comment: 'Best purchase ever',
    isVerifiedPurchase: true,
    helpfulCount: 0,
    userName: 'Test User',
    createdAt: DateTime.now(),
  );

  setUpAll(() {
    registerFallbackValue(FakeGetProductReviewsParams());
    registerFallbackValue(FakeAddReviewParams());
  });

  setUp(() {
    mockGetProductReviewsUsecase = MockGetProductReviewsUsecase();
    mockAddReviewUsecase = MockAddReviewUsecase();

    reviewsCubit = ReviewsCubit(
      getProductReviewsUsecase: mockGetProductReviewsUsecase,
      addReviewUsecase: mockAddReviewUsecase,
    );
  });

  tearDown(() {
    reviewsCubit.close();
  });

  group('ReviewsCubit', () {
    test('initial state is ReviewsInitial', () {
      expect(reviewsCubit.state, ReviewsInitial());
    });

    group('getProductReviews', () {
      blocTest<ReviewsCubit, ReviewsState>(
        'emits [ReviewsLoading, ReviewsLoaded] when getProductReviews succeeds',
        build: () {
          when(() => mockGetProductReviewsUsecase(any()))
              .thenAnswer((_) async => Right(testReviews));
          return reviewsCubit;
        },
        act: (cubit) => cubit.getProductReviews(testProductId),
        expect: () => [
          ReviewsLoading(),
          isA<ReviewsLoaded>()
              .having((s) => s.reviews.length, 'reviews count', 2)
              .having((s) => s.hasReachedMax, 'hasReachedMax', true)
              .having((s) => s.currentPage, 'currentPage', 1),
        ],
      );

      blocTest<ReviewsCubit, ReviewsState>(
        'emits [ReviewsLoading, ReviewsError] when getProductReviews fails',
        build: () {
          when(() => mockGetProductReviewsUsecase(any()))
              .thenAnswer((_) async => const Left('Failed to load reviews'));
          return reviewsCubit;
        },
        act: (cubit) => cubit.getProductReviews(testProductId),
        expect: () => [
          ReviewsLoading(),
          const ReviewsError('Failed to load reviews'),
        ],
      );

      blocTest<ReviewsCubit, ReviewsState>(
        'emits [ReviewsLoading, ReviewsLoaded] with empty list when no reviews',
        build: () {
          when(() => mockGetProductReviewsUsecase(any()))
              .thenAnswer((_) async => const Right([]));
          return reviewsCubit;
        },
        act: (cubit) => cubit.getProductReviews(testProductId),
        expect: () => [
          ReviewsLoading(),
          isA<ReviewsLoaded>()
              .having((s) => s.reviews, 'reviews', isEmpty)
              .having((s) => s.hasReachedMax, 'hasReachedMax', true),
        ],
      );

      blocTest<ReviewsCubit, ReviewsState>(
        'refresh resets pagination and loads fresh reviews',
        build: () {
          when(() => mockGetProductReviewsUsecase(any()))
              .thenAnswer((_) async => Right(testReviews));
          return reviewsCubit;
        },
        act: (cubit) => cubit.getProductReviews(testProductId, refresh: true),
        expect: () => [
          ReviewsLoading(),
          isA<ReviewsLoaded>()
              .having((s) => s.reviews.length, 'reviews count', 2)
              .having((s) => s.currentPage, 'currentPage', 1),
        ],
      );
    });

    group('addReview', () {
      blocTest<ReviewsCubit, ReviewsState>(
        'emits [ReviewAdding, ReviewAdded] then refreshes when addReview succeeds',
        build: () {
          when(() => mockAddReviewUsecase(any()))
              .thenAnswer((_) async => Right(newReview));
          when(() => mockGetProductReviewsUsecase(any()))
              .thenAnswer((_) async => Right([newReview, ...testReviews]));
          return reviewsCubit;
        },
        act: (cubit) => cubit.addReview(
          productId: testProductId,
          rating: 5,
          title: 'Amazing!',
          comment: 'Best purchase ever',
        ),
        expect: () => [
          ReviewAdding(),
          ReviewAdded(newReview),
          ReviewsLoading(),
          isA<ReviewsLoaded>()
              .having((s) => s.reviews.length, 'reviews count', 3),
        ],
      );

      blocTest<ReviewsCubit, ReviewsState>(
        'emits [ReviewAdding, ReviewsError] when addReview fails',
        build: () {
          when(() => mockAddReviewUsecase(any()))
              .thenAnswer((_) async => const Left('Failed to add review'));
          return reviewsCubit;
        },
        act: (cubit) => cubit.addReview(
          productId: testProductId,
          rating: 5,
        ),
        expect: () => [
          ReviewAdding(),
          const ReviewsError('Failed to add review'),
        ],
      );

      blocTest<ReviewsCubit, ReviewsState>(
        'passes all parameters to usecase',
        build: () {
          when(() => mockAddReviewUsecase(any()))
              .thenAnswer((_) async => Right(newReview));
          when(() => mockGetProductReviewsUsecase(any()))
              .thenAnswer((_) async => Right([newReview]));
          return reviewsCubit;
        },
        act: (cubit) => cubit.addReview(
          productId: testProductId,
          rating: 4,
          title: 'Test Title',
          comment: 'Test Comment',
          images: ['image1.jpg', 'image2.jpg'],
        ),
        verify: (_) {
          final captured =
              verify(() => mockAddReviewUsecase(captureAny())).captured.first
                  as AddReviewParams;
          expect(captured.productId, testProductId);
          expect(captured.rating, 4);
          expect(captured.title, 'Test Title');
          expect(captured.comment, 'Test Comment');
          expect(captured.images, ['image1.jpg', 'image2.jpg']);
        },
      );
    });

    group('resetReviews', () {
      blocTest<ReviewsCubit, ReviewsState>(
        'emits ReviewsInitial when resetReviews is called',
        build: () => reviewsCubit,
        seed: () => ReviewsLoaded(reviews: testReviews, currentPage: 2),
        act: (cubit) => cubit.resetReviews(),
        expect: () => [ReviewsInitial()],
      );
    });
  });

  group('ReviewEntity', () {
    test('copyWith creates a new instance with updated values', () {
      final original = testReviews.first;
      final updated = original.copyWith(rating: 3, title: 'Updated title');

      expect(updated.id, original.id);
      expect(updated.userId, original.userId);
      expect(updated.rating, 3);
      expect(updated.title, 'Updated title');
      expect(updated.comment, original.comment);
    });

    test('equality works correctly', () {
      final review1 = ReviewEntity(
        id: 'review-1',
        userId: 'user-1',
        productId: 'product-1',
        rating: 5,
        createdAt: DateTime(2024, 1, 15),
      );

      final review2 = ReviewEntity(
        id: 'review-1',
        userId: 'user-1',
        productId: 'product-1',
        rating: 5,
        createdAt: DateTime(2024, 1, 15),
      );

      expect(review1, equals(review2));
    });
  });

  group('ProductReviewStats', () {
    test('star count getters return correct values', () {
      const stats = ProductReviewStats(
        averageRating: 4.2,
        totalReviews: 100,
        ratingDistribution: {5: 40, 4: 30, 3: 15, 2: 10, 1: 5},
      );

      expect(stats.fiveStarCount, 40);
      expect(stats.fourStarCount, 30);
      expect(stats.threeStarCount, 15);
      expect(stats.twoStarCount, 10);
      expect(stats.oneStarCount, 5);
    });

    test('getPercentage calculates correctly', () {
      const stats = ProductReviewStats(
        averageRating: 4.2,
        totalReviews: 100,
        ratingDistribution: {5: 40, 4: 30, 3: 15, 2: 10, 1: 5},
      );

      expect(stats.getPercentage(5), 40.0);
      expect(stats.getPercentage(4), 30.0);
      expect(stats.getPercentage(3), 15.0);
      expect(stats.getPercentage(2), 10.0);
      expect(stats.getPercentage(1), 5.0);
    });

    test('getPercentage returns 0 when totalReviews is 0', () {
      const stats = ProductReviewStats(
        averageRating: 0,
        totalReviews: 0,
        ratingDistribution: {},
      );

      expect(stats.getPercentage(5), 0.0);
    });

    test('star count returns 0 for missing ratings', () {
      const stats = ProductReviewStats(
        averageRating: 5.0,
        totalReviews: 10,
        ratingDistribution: {5: 10},
      );

      expect(stats.fourStarCount, 0);
      expect(stats.threeStarCount, 0);
      expect(stats.twoStarCount, 0);
      expect(stats.oneStarCount, 0);
    });
  });

  group('ReviewsLoaded', () {
    test('copyWith creates a new instance with updated values', () {
      final state = ReviewsLoaded(
        reviews: testReviews,
        hasReachedMax: false,
        currentPage: 1,
      );

      final updated = state.copyWith(hasReachedMax: true, currentPage: 2);

      expect(updated.reviews, testReviews);
      expect(updated.hasReachedMax, true);
      expect(updated.currentPage, 2);
    });
  });
}
