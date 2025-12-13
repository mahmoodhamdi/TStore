import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:t_store/features/shop/domain/entities/product_entity.dart';
import 'package:t_store/features/shop/domain/usecases/get_products_usecase.dart';
import 'package:t_store/features/shop/domain/usecases/get_product_by_id_usecase.dart';
import 'package:t_store/features/shop/domain/usecases/search_products_usecase.dart';
import 'package:t_store/features/shop/presentation/cubit/products_cubit.dart';
import 'package:t_store/features/shop/presentation/cubit/products_state.dart';

// Mocks
class MockGetProductsUsecase extends Mock implements GetProductsUsecase {}

class MockGetProductByIdUsecase extends Mock implements GetProductByIdUsecase {}

class MockSearchProductsUsecase extends Mock implements SearchProductsUsecase {}

// Fake classes for registerFallbackValue
class FakeGetProductsParams extends Fake implements GetProductsParams {}

void main() {
  late ProductsCubit productsCubit;
  late MockGetProductsUsecase mockGetProductsUsecase;
  late MockGetProductByIdUsecase mockGetProductByIdUsecase;
  late MockSearchProductsUsecase mockSearchProductsUsecase;

  // Test data
  final testProducts = [
    const ProductEntity(
      id: 'product-1',
      name: 'Test Product 1',
      description: 'Description 1',
      price: 99.99,
      salePrice: 79.99,
      categoryId: 'cat-1',
      brandId: 'brand-1',
      stock: 10,
      images: ['image1.jpg', 'image2.jpg'],
      thumbnail: 'thumb1.jpg',
      rating: 4.5,
      reviewsCount: 10,
      isFeatured: true,
    ),
    const ProductEntity(
      id: 'product-2',
      name: 'Test Product 2',
      description: 'Description 2',
      price: 149.99,
      categoryId: 'cat-2',
      stock: 5,
      images: ['image3.jpg'],
      rating: 3.8,
      reviewsCount: 5,
    ),
  ];

  setUpAll(() {
    registerFallbackValue(FakeGetProductsParams());
  });

  setUp(() {
    mockGetProductsUsecase = MockGetProductsUsecase();
    mockGetProductByIdUsecase = MockGetProductByIdUsecase();
    mockSearchProductsUsecase = MockSearchProductsUsecase();

    productsCubit = ProductsCubit(
      getProductsUsecase: mockGetProductsUsecase,
      getProductByIdUsecase: mockGetProductByIdUsecase,
      searchProductsUsecase: mockSearchProductsUsecase,
    );
  });

  tearDown(() {
    productsCubit.close();
  });

  group('ProductsCubit', () {
    test('initial state is ProductsInitial', () {
      expect(productsCubit.state, ProductsInitial());
    });

    group('getProducts', () {
      blocTest<ProductsCubit, ProductsState>(
        'emits [ProductsLoading, ProductsLoaded] when getProducts succeeds',
        build: () {
          when(() => mockGetProductsUsecase(any()))
              .thenAnswer((_) async => Right(testProducts));
          return productsCubit;
        },
        act: (cubit) => cubit.getProducts(),
        expect: () => [
          ProductsLoading(),
          ProductsLoaded(
            products: testProducts,
            hasReachedMax: true,
            currentPage: 1,
          ),
        ],
      );

      blocTest<ProductsCubit, ProductsState>(
        'emits [ProductsLoading, ProductsError] when getProducts fails',
        build: () {
          when(() => mockGetProductsUsecase(any()))
              .thenAnswer((_) async => const Left('Failed to fetch products'));
          return productsCubit;
        },
        act: (cubit) => cubit.getProducts(),
        expect: () => [
          ProductsLoading(),
          const ProductsError('Failed to fetch products'),
        ],
      );

      blocTest<ProductsCubit, ProductsState>(
        'emits [ProductsLoading, ProductsLoaded] with hasReachedMax=false when more products available',
        build: () {
          // Return exactly 20 products to indicate more may be available
          final manyProducts =
              List.generate(20, (i) => testProducts.first.copyWith(id: 'p$i'));
          when(() => mockGetProductsUsecase(any()))
              .thenAnswer((_) async => Right(manyProducts));
          return productsCubit;
        },
        act: (cubit) => cubit.getProducts(),
        expect: () {
          return [
            ProductsLoading(),
            isA<ProductsLoaded>()
                .having((s) => s.products.length, 'products length', 20)
                .having((s) => s.hasReachedMax, 'hasReachedMax', false),
          ];
        },
      );

      blocTest<ProductsCubit, ProductsState>(
        'passes filter parameters to usecase',
        build: () {
          when(() => mockGetProductsUsecase(any()))
              .thenAnswer((_) async => Right(testProducts));
          return productsCubit;
        },
        act: (cubit) => cubit.getProducts(
          categoryId: 'cat-1',
          brandId: 'brand-1',
          isFeatured: true,
          sortBy: 'price',
          ascending: false,
        ),
        verify: (_) {
          final captured = verify(() => mockGetProductsUsecase(captureAny()))
              .captured
              .first as GetProductsParams;
          expect(captured.categoryId, 'cat-1');
          expect(captured.brandId, 'brand-1');
          expect(captured.isFeatured, true);
          expect(captured.sortBy, 'price');
          expect(captured.ascending, false);
        },
      );

      blocTest<ProductsCubit, ProductsState>(
        'resets pagination when refresh is true',
        build: () {
          when(() => mockGetProductsUsecase(any()))
              .thenAnswer((_) async => Right(testProducts));
          return productsCubit;
        },
        seed: () => ProductsLoaded(
          products: testProducts,
          currentPage: 5,
          hasReachedMax: false,
        ),
        act: (cubit) => cubit.getProducts(refresh: true),
        verify: (_) {
          final captured = verify(() => mockGetProductsUsecase(captureAny()))
              .captured
              .first as GetProductsParams;
          expect(captured.page, 0);
        },
      );
    });

    group('getProductById', () {
      blocTest<ProductsCubit, ProductsState>(
        'emits [ProductDetailLoading, ProductDetailLoaded] when getProductById succeeds',
        build: () {
          when(() => mockGetProductByIdUsecase('product-1'))
              .thenAnswer((_) async => Right(testProducts.first));
          return productsCubit;
        },
        act: (cubit) => cubit.getProductById('product-1'),
        expect: () => [
          ProductDetailLoading(),
          ProductDetailLoaded(testProducts.first),
        ],
      );

      blocTest<ProductsCubit, ProductsState>(
        'emits [ProductDetailLoading, ProductDetailError] when getProductById fails',
        build: () {
          when(() => mockGetProductByIdUsecase('non-existent'))
              .thenAnswer((_) async => const Left('Product not found'));
          return productsCubit;
        },
        act: (cubit) => cubit.getProductById('non-existent'),
        expect: () => [
          ProductDetailLoading(),
          const ProductDetailError('Product not found'),
        ],
      );
    });

    group('searchProducts', () {
      blocTest<ProductsCubit, ProductsState>(
        'emits [ProductsSearching, ProductsSearchResult] when search succeeds',
        build: () {
          when(() => mockSearchProductsUsecase('Test'))
              .thenAnswer((_) async => Right(testProducts));
          return productsCubit;
        },
        act: (cubit) => cubit.searchProducts('Test'),
        expect: () => [
          ProductsSearching(),
          ProductsSearchResult(products: testProducts, query: 'Test'),
        ],
      );

      blocTest<ProductsCubit, ProductsState>(
        'emits ProductsInitial when search query is empty',
        build: () => productsCubit,
        act: (cubit) => cubit.searchProducts(''),
        expect: () => [ProductsInitial()],
      );

      blocTest<ProductsCubit, ProductsState>(
        'emits [ProductsSearching, ProductsError] when search fails',
        build: () {
          when(() => mockSearchProductsUsecase('Test'))
              .thenAnswer((_) async => const Left('Search failed'));
          return productsCubit;
        },
        act: (cubit) => cubit.searchProducts('Test'),
        expect: () => [
          ProductsSearching(),
          const ProductsError('Search failed'),
        ],
      );

      blocTest<ProductsCubit, ProductsState>(
        'emits empty search result when no products match',
        build: () {
          when(() => mockSearchProductsUsecase('NonExistent'))
              .thenAnswer((_) async => const Right([]));
          return productsCubit;
        },
        act: (cubit) => cubit.searchProducts('NonExistent'),
        expect: () => [
          ProductsSearching(),
          const ProductsSearchResult(products: [], query: 'NonExistent'),
        ],
      );
    });

    group('resetProducts', () {
      blocTest<ProductsCubit, ProductsState>(
        'emits ProductsInitial when resetProducts is called',
        build: () => productsCubit,
        seed: () => ProductsLoaded(products: testProducts, currentPage: 3),
        act: (cubit) => cubit.resetProducts(),
        expect: () => [ProductsInitial()],
      );
    });

    group('loadMoreProducts', () {
      blocTest<ProductsCubit, ProductsState>(
        'does nothing when hasReachedMax is true',
        build: () => productsCubit,
        seed: () => ProductsLoaded(
          products: testProducts,
          hasReachedMax: true,
          currentPage: 1,
        ),
        act: (cubit) => cubit.loadMoreProducts(),
        expect: () => [],
        verify: (_) {
          verifyNever(() => mockGetProductsUsecase(any()));
        },
      );

      blocTest<ProductsCubit, ProductsState>(
        'does nothing when state is not ProductsLoaded',
        build: () => productsCubit,
        seed: () => ProductsLoading(),
        act: (cubit) => cubit.loadMoreProducts(),
        expect: () => [],
        verify: (_) {
          verifyNever(() => mockGetProductsUsecase(any()));
        },
      );
    });
  });
}
