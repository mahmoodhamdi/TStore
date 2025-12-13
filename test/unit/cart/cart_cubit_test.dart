import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:t_store/core/usecases/usecase.dart';
import 'package:t_store/features/cart/domain/entities/cart_item_entity.dart';
import 'package:t_store/features/cart/domain/usecases/get_cart_items_usecase.dart';
import 'package:t_store/features/cart/domain/usecases/add_to_cart_usecase.dart';
import 'package:t_store/features/cart/domain/usecases/update_cart_item_usecase.dart';
import 'package:t_store/features/cart/domain/usecases/remove_from_cart_usecase.dart';
import 'package:t_store/features/cart/domain/usecases/clear_cart_usecase.dart';
import 'package:t_store/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:t_store/features/cart/presentation/cubit/cart_state.dart';
import 'package:t_store/features/shop/domain/entities/product_entity.dart';

// Mocks
class MockGetCartItemsUsecase extends Mock implements GetCartItemsUsecase {}

class MockAddToCartUsecase extends Mock implements AddToCartUsecase {}

class MockUpdateCartItemUsecase extends Mock implements UpdateCartItemUsecase {}

class MockRemoveFromCartUsecase extends Mock implements RemoveFromCartUsecase {}

class MockClearCartUsecase extends Mock implements ClearCartUsecase {}

// Fakes
class FakeNoParams extends Fake implements NoParams {}

class FakeAddToCartParams extends Fake implements AddToCartParams {}

class FakeUpdateCartItemParams extends Fake implements UpdateCartItemParams {}

void main() {
  late CartCubit cartCubit;
  late MockGetCartItemsUsecase mockGetCartItemsUsecase;
  late MockAddToCartUsecase mockAddToCartUsecase;
  late MockUpdateCartItemUsecase mockUpdateCartItemUsecase;
  late MockRemoveFromCartUsecase mockRemoveFromCartUsecase;
  late MockClearCartUsecase mockClearCartUsecase;

  // Test data
  const testProduct = ProductEntity(
    id: 'product-1',
    name: 'Test Product',
    price: 100,
    salePrice: 80,
    categoryId: 'cat-1',
    stock: 10,
    images: [],
  );

  final testCartItems = [
    const CartItemEntity(
      id: 'cart-1',
      userId: 'user-1',
      productId: 'product-1',
      quantity: 2,
      product: testProduct,
    ),
    const CartItemEntity(
      id: 'cart-2',
      userId: 'user-1',
      productId: 'product-2',
      quantity: 1,
      product: ProductEntity(
        id: 'product-2',
        name: 'Test Product 2',
        price: 50,
        categoryId: 'cat-1',
        stock: 5,
        images: [],
      ),
    ),
  ];

  setUpAll(() {
    registerFallbackValue(FakeNoParams());
    registerFallbackValue(FakeAddToCartParams());
    registerFallbackValue(FakeUpdateCartItemParams());
  });

  setUp(() {
    mockGetCartItemsUsecase = MockGetCartItemsUsecase();
    mockAddToCartUsecase = MockAddToCartUsecase();
    mockUpdateCartItemUsecase = MockUpdateCartItemUsecase();
    mockRemoveFromCartUsecase = MockRemoveFromCartUsecase();
    mockClearCartUsecase = MockClearCartUsecase();

    cartCubit = CartCubit(
      getCartItemsUsecase: mockGetCartItemsUsecase,
      addToCartUsecase: mockAddToCartUsecase,
      updateCartItemUsecase: mockUpdateCartItemUsecase,
      removeFromCartUsecase: mockRemoveFromCartUsecase,
      clearCartUsecase: mockClearCartUsecase,
    );
  });

  tearDown(() {
    cartCubit.close();
  });

  group('CartCubit', () {
    test('initial state is CartInitial', () {
      expect(cartCubit.state, CartInitial());
    });

    group('getCartItems', () {
      blocTest<CartCubit, CartState>(
        'emits [CartLoading, CartLoaded] when getCartItems succeeds',
        build: () {
          when(() => mockGetCartItemsUsecase(any()))
              .thenAnswer((_) async => Right(testCartItems));
          return cartCubit;
        },
        act: (cubit) => cubit.getCartItems(),
        expect: () => [
          CartLoading(),
          CartLoaded(testCartItems),
        ],
      );

      blocTest<CartCubit, CartState>(
        'emits [CartLoading, CartError] when getCartItems fails',
        build: () {
          when(() => mockGetCartItemsUsecase(any()))
              .thenAnswer((_) async => const Left('Failed to load cart'));
          return cartCubit;
        },
        act: (cubit) => cubit.getCartItems(),
        expect: () => [
          CartLoading(),
          const CartError('Failed to load cart'),
        ],
      );

      blocTest<CartCubit, CartState>(
        'emits [CartLoading, CartLoaded] with empty list when cart is empty',
        build: () {
          when(() => mockGetCartItemsUsecase(any()))
              .thenAnswer((_) async => const Right([]));
          return cartCubit;
        },
        act: (cubit) => cubit.getCartItems(),
        expect: () => [
          CartLoading(),
          const CartLoaded([]),
        ],
      );
    });

    group('addToCart', () {
      blocTest<CartCubit, CartState>(
        'emits [CartItemAdded] and refreshes cart when addToCart succeeds',
        build: () {
          when(() => mockAddToCartUsecase(any()))
              .thenAnswer((_) async => Right(testCartItems.first));
          when(() => mockGetCartItemsUsecase(any()))
              .thenAnswer((_) async => Right(testCartItems));
          return cartCubit;
        },
        act: (cubit) => cubit.addToCart(productId: 'product-1', quantity: 2),
        expect: () => [
          CartItemAdded(testCartItems.first),
          CartLoading(),
          CartLoaded(testCartItems),
        ],
        verify: (_) {
          final captured = verify(() => mockAddToCartUsecase(captureAny()))
              .captured
              .first as AddToCartParams;
          expect(captured.productId, 'product-1');
          expect(captured.quantity, 2);
        },
      );

      blocTest<CartCubit, CartState>(
        'emits [CartError] when addToCart fails',
        build: () {
          when(() => mockAddToCartUsecase(any()))
              .thenAnswer((_) async => const Left('Failed to add item'));
          return cartCubit;
        },
        act: (cubit) => cubit.addToCart(productId: 'product-1'),
        expect: () => [
          const CartError('Failed to add item'),
        ],
      );

      blocTest<CartCubit, CartState>(
        'passes selectedAttributes when provided',
        build: () {
          when(() => mockAddToCartUsecase(any()))
              .thenAnswer((_) async => Right(testCartItems.first));
          when(() => mockGetCartItemsUsecase(any()))
              .thenAnswer((_) async => Right(testCartItems));
          return cartCubit;
        },
        act: (cubit) => cubit.addToCart(
          productId: 'product-1',
          selectedAttributes: {'color': 'red', 'size': 'M'},
        ),
        verify: (_) {
          final captured = verify(() => mockAddToCartUsecase(captureAny()))
              .captured
              .first as AddToCartParams;
          expect(captured.selectedAttributes, {'color': 'red', 'size': 'M'});
        },
      );
    });

    group('updateCartItem', () {
      blocTest<CartCubit, CartState>(
        'emits [CartItemUpdated] and refreshes cart when update succeeds',
        build: () {
          when(() => mockUpdateCartItemUsecase(any()))
              .thenAnswer((_) async => Right(testCartItems.first));
          when(() => mockGetCartItemsUsecase(any()))
              .thenAnswer((_) async => Right(testCartItems));
          return cartCubit;
        },
        act: (cubit) => cubit.updateCartItem(cartItemId: 'cart-1', quantity: 3),
        expect: () => [
          CartItemUpdated(testCartItems.first),
          CartLoading(),
          CartLoaded(testCartItems),
        ],
      );

      blocTest<CartCubit, CartState>(
        'emits [CartItemRemoved] when quantity becomes 0',
        build: () {
          when(() => mockUpdateCartItemUsecase(any())).thenAnswer(
              (_) async => const Left('تم إزالة المنتج من السلة'));
          when(() => mockGetCartItemsUsecase(any()))
              .thenAnswer((_) async => const Right([]));
          return cartCubit;
        },
        act: (cubit) => cubit.updateCartItem(cartItemId: 'cart-1', quantity: 0),
        expect: () => [
          const CartItemRemoved('cart-1'),
          CartLoading(),
          const CartLoaded([]),
        ],
      );

      blocTest<CartCubit, CartState>(
        'emits [CartError] when update fails with other error',
        build: () {
          when(() => mockUpdateCartItemUsecase(any()))
              .thenAnswer((_) async => const Left('Update failed'));
          when(() => mockGetCartItemsUsecase(any()))
              .thenAnswer((_) async => Right(testCartItems));
          return cartCubit;
        },
        act: (cubit) => cubit.updateCartItem(cartItemId: 'cart-1', quantity: 5),
        expect: () => [
          const CartError('Update failed'),
          CartLoading(),
          CartLoaded(testCartItems),
        ],
      );
    });

    group('removeFromCart', () {
      blocTest<CartCubit, CartState>(
        'emits [CartItemRemoved] and refreshes cart when remove succeeds',
        build: () {
          when(() => mockRemoveFromCartUsecase('cart-1'))
              .thenAnswer((_) async => const Right(null));
          when(() => mockGetCartItemsUsecase(any()))
              .thenAnswer((_) async => Right([testCartItems[1]]));
          return cartCubit;
        },
        act: (cubit) => cubit.removeFromCart('cart-1'),
        expect: () => [
          const CartItemRemoved('cart-1'),
          CartLoading(),
          CartLoaded([testCartItems[1]]),
        ],
      );

      blocTest<CartCubit, CartState>(
        'emits [CartError] when remove fails',
        build: () {
          when(() => mockRemoveFromCartUsecase('cart-1'))
              .thenAnswer((_) async => const Left('Remove failed'));
          return cartCubit;
        },
        act: (cubit) => cubit.removeFromCart('cart-1'),
        expect: () => [
          const CartError('Remove failed'),
        ],
      );
    });

    group('clearCart', () {
      blocTest<CartCubit, CartState>(
        'emits [CartCleared, CartLoaded(empty)] when clear succeeds',
        build: () {
          when(() => mockClearCartUsecase(any()))
              .thenAnswer((_) async => const Right(null));
          return cartCubit;
        },
        act: (cubit) => cubit.clearCart(),
        expect: () => [
          CartCleared(),
          const CartLoaded([]),
        ],
      );

      blocTest<CartCubit, CartState>(
        'emits [CartError] when clear fails',
        build: () {
          when(() => mockClearCartUsecase(any()))
              .thenAnswer((_) async => const Left('Clear failed'));
          return cartCubit;
        },
        act: (cubit) => cubit.clearCart(),
        expect: () => [
          const CartError('Clear failed'),
        ],
      );
    });

    group('itemCount and totalPrice', () {
      test('itemCount returns 0 when state is not CartLoaded', () {
        expect(cartCubit.itemCount, 0);
      });

      test('totalPrice returns 0 when state is not CartLoaded', () {
        expect(cartCubit.totalPrice, 0);
      });
    });
  });

  group('CartLoaded', () {
    test('itemCount calculates total quantity correctly', () {
      final state = CartLoaded(testCartItems);
      // 2 + 1 = 3
      expect(state.itemCount, 3);
    });

    test('totalPrice calculates total correctly', () {
      final state = CartLoaded(testCartItems);
      // (80 * 2) + (50 * 1) = 160 + 50 = 210
      expect(state.totalPrice, 210);
    });

    test('isEmpty returns true when items list is empty', () {
      const state = CartLoaded([]);
      expect(state.isEmpty, true);
    });

    test('isEmpty returns false when items exist', () {
      final state = CartLoaded(testCartItems);
      expect(state.isEmpty, false);
    });
  });

  group('CartItemEntity', () {
    test('totalPrice calculates correctly with product', () {
      const item = CartItemEntity(
        id: 'cart-1',
        userId: 'user-1',
        productId: 'product-1',
        quantity: 3,
        product: testProduct,
      );
      // 80 (sale price) * 3 = 240
      expect(item.totalPrice, 240);
    });

    test('totalPrice returns 0 when product is null', () {
      const item = CartItemEntity(
        id: 'cart-1',
        userId: 'user-1',
        productId: 'product-1',
        quantity: 3,
      );
      expect(item.totalPrice, 0);
    });

    test('copyWith creates a new instance with updated values', () {
      final original = testCartItems.first;
      final updated = original.copyWith(quantity: 5);

      expect(updated.id, original.id);
      expect(updated.quantity, 5);
      expect(updated.productId, original.productId);
    });
  });
}
