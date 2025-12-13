import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:t_store/core/usecases/usecase.dart';
import 'package:t_store/features/shop/domain/entities/product_entity.dart';
import 'package:t_store/features/wishlist/domain/entities/wishlist_item_entity.dart';
import 'package:t_store/features/wishlist/domain/usecases/get_wishlist_usecase.dart';
import 'package:t_store/features/wishlist/domain/usecases/add_to_wishlist_usecase.dart';
import 'package:t_store/features/wishlist/domain/usecases/remove_from_wishlist_usecase.dart';
import 'package:t_store/features/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:t_store/features/wishlist/presentation/cubit/wishlist_state.dart';

// Mocks
class MockGetWishlistUsecase extends Mock implements GetWishlistUsecase {}

class MockAddToWishlistUsecase extends Mock implements AddToWishlistUsecase {}

class MockRemoveFromWishlistUsecase extends Mock
    implements RemoveFromWishlistUsecase {}

// Fakes
class FakeNoParams extends Fake implements NoParams {}

void main() {
  late WishlistCubit wishlistCubit;
  late MockGetWishlistUsecase mockGetWishlistUsecase;
  late MockAddToWishlistUsecase mockAddToWishlistUsecase;
  late MockRemoveFromWishlistUsecase mockRemoveFromWishlistUsecase;

  // Test data
  const testProduct1 = ProductEntity(
    id: 'product-1',
    name: 'Test Product 1',
    price: 100,
    categoryId: 'cat-1',
    stock: 10,
    images: [],
  );

  const testProduct2 = ProductEntity(
    id: 'product-2',
    name: 'Test Product 2',
    price: 150,
    categoryId: 'cat-1',
    stock: 5,
    images: [],
  );

  final testWishlistItems = [
    const WishlistItemEntity(
      id: 'wishlist-1',
      userId: 'user-1',
      productId: 'product-1',
      product: testProduct1,
    ),
    const WishlistItemEntity(
      id: 'wishlist-2',
      userId: 'user-1',
      productId: 'product-2',
      product: testProduct2,
    ),
  ];

  setUpAll(() {
    registerFallbackValue(FakeNoParams());
  });

  setUp(() {
    mockGetWishlistUsecase = MockGetWishlistUsecase();
    mockAddToWishlistUsecase = MockAddToWishlistUsecase();
    mockRemoveFromWishlistUsecase = MockRemoveFromWishlistUsecase();

    wishlistCubit = WishlistCubit(
      getWishlistUsecase: mockGetWishlistUsecase,
      addToWishlistUsecase: mockAddToWishlistUsecase,
      removeFromWishlistUsecase: mockRemoveFromWishlistUsecase,
    );
  });

  tearDown(() {
    wishlistCubit.close();
  });

  group('WishlistCubit', () {
    test('initial state is WishlistInitial', () {
      expect(wishlistCubit.state, WishlistInitial());
    });

    group('getWishlist', () {
      blocTest<WishlistCubit, WishlistState>(
        'emits [WishlistLoading, WishlistLoaded] when getWishlist succeeds',
        build: () {
          when(() => mockGetWishlistUsecase(any()))
              .thenAnswer((_) async => Right(testWishlistItems));
          return wishlistCubit;
        },
        act: (cubit) => cubit.getWishlist(),
        expect: () => [
          WishlistLoading(),
          WishlistLoaded(testWishlistItems),
        ],
      );

      blocTest<WishlistCubit, WishlistState>(
        'emits [WishlistLoading, WishlistError] when getWishlist fails',
        build: () {
          when(() => mockGetWishlistUsecase(any()))
              .thenAnswer((_) async => const Left('Failed to load wishlist'));
          return wishlistCubit;
        },
        act: (cubit) => cubit.getWishlist(),
        expect: () => [
          WishlistLoading(),
          const WishlistError('Failed to load wishlist'),
        ],
      );

      blocTest<WishlistCubit, WishlistState>(
        'emits [WishlistLoading, WishlistLoaded] with empty list when wishlist is empty',
        build: () {
          when(() => mockGetWishlistUsecase(any()))
              .thenAnswer((_) async => const Right([]));
          return wishlistCubit;
        },
        act: (cubit) => cubit.getWishlist(),
        expect: () => [
          WishlistLoading(),
          WishlistLoaded(const []),
        ],
      );
    });

    group('addToWishlist', () {
      blocTest<WishlistCubit, WishlistState>(
        'emits [WishlistItemAdded] and refreshes wishlist when addToWishlist succeeds',
        build: () {
          when(() => mockAddToWishlistUsecase('product-1'))
              .thenAnswer((_) async => Right(testWishlistItems.first));
          when(() => mockGetWishlistUsecase(any()))
              .thenAnswer((_) async => Right(testWishlistItems));
          return wishlistCubit;
        },
        act: (cubit) => cubit.addToWishlist('product-1'),
        expect: () => [
          WishlistItemAdded(testWishlistItems.first),
          WishlistLoading(),
          WishlistLoaded(testWishlistItems),
        ],
      );

      blocTest<WishlistCubit, WishlistState>(
        'emits [WishlistError] when addToWishlist fails',
        build: () {
          when(() => mockAddToWishlistUsecase('product-1'))
              .thenAnswer((_) async => const Left('Failed to add to wishlist'));
          return wishlistCubit;
        },
        act: (cubit) => cubit.addToWishlist('product-1'),
        expect: () => [
          const WishlistError('Failed to add to wishlist'),
        ],
      );
    });

    group('removeFromWishlist', () {
      blocTest<WishlistCubit, WishlistState>(
        'emits [WishlistItemRemoved] and refreshes wishlist when removeFromWishlist succeeds',
        build: () {
          when(() => mockRemoveFromWishlistUsecase('product-1'))
              .thenAnswer((_) async => const Right(null));
          when(() => mockGetWishlistUsecase(any()))
              .thenAnswer((_) async => Right([testWishlistItems[1]]));
          return wishlistCubit;
        },
        act: (cubit) => cubit.removeFromWishlist('product-1'),
        expect: () => [
          const WishlistItemRemoved('product-1'),
          WishlistLoading(),
          WishlistLoaded([testWishlistItems[1]]),
        ],
      );

      blocTest<WishlistCubit, WishlistState>(
        'emits [WishlistError] when removeFromWishlist fails',
        build: () {
          when(() => mockRemoveFromWishlistUsecase('product-1'))
              .thenAnswer((_) async => const Left('Failed to remove'));
          return wishlistCubit;
        },
        act: (cubit) => cubit.removeFromWishlist('product-1'),
        expect: () => [
          const WishlistError('Failed to remove'),
        ],
      );
    });

    group('toggleWishlist', () {
      blocTest<WishlistCubit, WishlistState>(
        'adds item when product is not in wishlist',
        build: () {
          when(() => mockAddToWishlistUsecase('product-3'))
              .thenAnswer((_) async => Right(const WishlistItemEntity(
                    id: 'wishlist-3',
                    userId: 'user-1',
                    productId: 'product-3',
                  )));
          when(() => mockGetWishlistUsecase(any()))
              .thenAnswer((_) async => Right(testWishlistItems));
          return wishlistCubit;
        },
        act: (cubit) => cubit.toggleWishlist('product-3'),
        verify: (_) {
          verify(() => mockAddToWishlistUsecase('product-3')).called(1);
          verifyNever(() => mockRemoveFromWishlistUsecase(any()));
        },
      );

      blocTest<WishlistCubit, WishlistState>(
        'removes item when product is already in wishlist',
        build: () {
          // First load wishlist to populate _productIds
          when(() => mockGetWishlistUsecase(any()))
              .thenAnswer((_) async => Right(testWishlistItems));
          when(() => mockRemoveFromWishlistUsecase('product-1'))
              .thenAnswer((_) async => const Right(null));
          return wishlistCubit;
        },
        seed: () {
          // Simulate that wishlist was already loaded
          return WishlistLoaded(testWishlistItems);
        },
        act: (cubit) async {
          // First load to populate _productIds
          await cubit.getWishlist();
          // Then toggle
          await cubit.toggleWishlist('product-1');
        },
        verify: (_) {
          verify(() => mockRemoveFromWishlistUsecase('product-1')).called(1);
        },
      );
    });

    group('isInWishlist', () {
      test('returns false when wishlist has not been loaded', () {
        expect(wishlistCubit.isInWishlist('product-1'), false);
      });

      test('returns true when product is in wishlist', () async {
        when(() => mockGetWishlistUsecase(any()))
            .thenAnswer((_) async => Right(testWishlistItems));

        await wishlistCubit.getWishlist();

        expect(wishlistCubit.isInWishlist('product-1'), true);
        expect(wishlistCubit.isInWishlist('product-2'), true);
      });

      test('returns false when product is not in wishlist', () async {
        when(() => mockGetWishlistUsecase(any()))
            .thenAnswer((_) async => Right(testWishlistItems));

        await wishlistCubit.getWishlist();

        expect(wishlistCubit.isInWishlist('product-999'), false);
      });
    });

    group('itemCount', () {
      test('returns 0 when wishlist has not been loaded', () {
        expect(wishlistCubit.itemCount, 0);
      });

      test('returns correct count after wishlist is loaded', () async {
        when(() => mockGetWishlistUsecase(any()))
            .thenAnswer((_) async => Right(testWishlistItems));

        await wishlistCubit.getWishlist();

        expect(wishlistCubit.itemCount, 2);
      });
    });
  });

  group('WishlistLoaded', () {
    test('isInWishlist returns true for products in list', () {
      final state = WishlistLoaded(testWishlistItems);

      expect(state.isInWishlist('product-1'), true);
      expect(state.isInWishlist('product-2'), true);
    });

    test('isInWishlist returns false for products not in list', () {
      final state = WishlistLoaded(testWishlistItems);

      expect(state.isInWishlist('product-999'), false);
    });

    test('productIds set is populated from items', () {
      final state = WishlistLoaded(testWishlistItems);

      expect(state.productIds, {'product-1', 'product-2'});
    });
  });

  group('WishlistItemEntity', () {
    test('copyWith creates a new instance with updated values', () {
      final original = testWishlistItems.first;
      final updated = original.copyWith(productId: 'product-new');

      expect(updated.id, original.id);
      expect(updated.userId, original.userId);
      expect(updated.productId, 'product-new');
    });

    test('equality works correctly', () {
      const item1 = WishlistItemEntity(
        id: 'wishlist-1',
        userId: 'user-1',
        productId: 'product-1',
      );

      const item2 = WishlistItemEntity(
        id: 'wishlist-1',
        userId: 'user-1',
        productId: 'product-1',
      );

      expect(item1, equals(item2));
    });
  });
}
