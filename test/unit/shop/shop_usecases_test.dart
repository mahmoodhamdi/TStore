import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:t_store/features/shop/domain/entities/product_entity.dart';
import 'package:t_store/features/shop/domain/repositories/product_repository.dart';
import 'package:t_store/features/shop/domain/usecases/get_products_usecase.dart';
import 'package:t_store/features/shop/domain/usecases/get_product_by_id_usecase.dart';
import 'package:t_store/features/shop/domain/usecases/search_products_usecase.dart';

class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  late MockProductRepository mockRepository;

  // Test products
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

  setUp(() {
    mockRepository = MockProductRepository();
  });

  group('GetProductsUsecase', () {
    late GetProductsUsecase usecase;

    setUp(() {
      usecase = GetProductsUsecase(mockRepository);
    });

    test('should return list of products when successful', () async {
      // Arrange
      when(() => mockRepository.getProducts(
            page: 0,
            limit: 20,
            categoryId: null,
            brandId: null,
            isFeatured: null,
            sortBy: null,
            ascending: true,
          )).thenAnswer((_) async => Right(testProducts));

      // Act
      final result = await usecase(GetProductsParams());

      // Assert
      expect(result.isRight(), true);
      result.fold(
        (error) => fail('Expected Right but got Left: $error'),
        (products) {
          expect(products.length, 2);
          expect(products.first.id, 'product-1');
          expect(products.first.name, 'Test Product 1');
        },
      );
    });

    test('should filter by category when categoryId is provided', () async {
      // Arrange
      final categoryProducts = [testProducts.first];
      when(() => mockRepository.getProducts(
            page: 0,
            limit: 20,
            categoryId: 'cat-1',
            brandId: null,
            isFeatured: null,
            sortBy: null,
            ascending: true,
          )).thenAnswer((_) async => Right(categoryProducts));

      // Act
      final result = await usecase(GetProductsParams(categoryId: 'cat-1'));

      // Assert
      expect(result.isRight(), true);
      result.fold(
        (error) => fail('Expected Right'),
        (products) => expect(products.length, 1),
      );
    });

    test('should filter featured products when isFeatured is true', () async {
      // Arrange
      final featuredProducts = [testProducts.first];
      when(() => mockRepository.getProducts(
            page: 0,
            limit: 20,
            categoryId: null,
            brandId: null,
            isFeatured: true,
            sortBy: null,
            ascending: true,
          )).thenAnswer((_) async => Right(featuredProducts));

      // Act
      final result = await usecase(GetProductsParams(isFeatured: true));

      // Assert
      expect(result.isRight(), true);
      result.fold(
        (error) => fail('Expected Right'),
        (products) {
          expect(products.length, 1);
          expect(products.first.isFeatured, true);
        },
      );
    });

    test('should return error when repository fails', () async {
      // Arrange
      when(() => mockRepository.getProducts(
            page: any(named: 'page'),
            limit: any(named: 'limit'),
            categoryId: any(named: 'categoryId'),
            brandId: any(named: 'brandId'),
            isFeatured: any(named: 'isFeatured'),
            sortBy: any(named: 'sortBy'),
            ascending: any(named: 'ascending'),
          )).thenAnswer((_) async => const Left('Failed to fetch products'));

      // Act
      final result = await usecase(GetProductsParams());

      // Assert
      expect(result.isLeft(), true);
      result.fold(
        (error) => expect(error, 'Failed to fetch products'),
        (products) => fail('Expected Left'),
      );
    });

    test('should support pagination', () async {
      // Arrange
      when(() => mockRepository.getProducts(
            page: 1,
            limit: 10,
            categoryId: null,
            brandId: null,
            isFeatured: null,
            sortBy: null,
            ascending: true,
          )).thenAnswer((_) async => Right(testProducts));

      // Act
      final result = await usecase(GetProductsParams(page: 1, limit: 10));

      // Assert
      expect(result.isRight(), true);
      verify(() => mockRepository.getProducts(
            page: 1,
            limit: 10,
            categoryId: null,
            brandId: null,
            isFeatured: null,
            sortBy: null,
            ascending: true,
          )).called(1);
    });

    test('should support sorting', () async {
      // Arrange
      when(() => mockRepository.getProducts(
            page: 0,
            limit: 20,
            categoryId: null,
            brandId: null,
            isFeatured: null,
            sortBy: 'price',
            ascending: false,
          )).thenAnswer((_) async => Right(testProducts));

      // Act
      final result = await usecase(
          GetProductsParams(sortBy: 'price', ascending: false));

      // Assert
      expect(result.isRight(), true);
    });
  });

  group('GetProductByIdUsecase', () {
    late GetProductByIdUsecase usecase;

    setUp(() {
      usecase = GetProductByIdUsecase(mockRepository);
    });

    test('should return product when found', () async {
      // Arrange
      when(() => mockRepository.getProductById('product-1'))
          .thenAnswer((_) async => Right(testProducts.first));

      // Act
      final result = await usecase('product-1');

      // Assert
      expect(result.isRight(), true);
      result.fold(
        (error) => fail('Expected Right'),
        (product) {
          expect(product.id, 'product-1');
          expect(product.name, 'Test Product 1');
          expect(product.price, 99.99);
          expect(product.salePrice, 79.99);
        },
      );
    });

    test('should return error when product not found', () async {
      // Arrange
      when(() => mockRepository.getProductById('non-existent'))
          .thenAnswer((_) async => const Left('Product not found'));

      // Act
      final result = await usecase('non-existent');

      // Assert
      expect(result.isLeft(), true);
      result.fold(
        (error) => expect(error, 'Product not found'),
        (product) => fail('Expected Left'),
      );
    });
  });

  group('SearchProductsUsecase', () {
    late SearchProductsUsecase usecase;

    setUp(() {
      usecase = SearchProductsUsecase(mockRepository);
    });

    test('should return matching products when search is successful', () async {
      // Arrange
      when(() => mockRepository.searchProducts('Test'))
          .thenAnswer((_) async => Right(testProducts));

      // Act
      final result = await usecase('Test');

      // Assert
      expect(result.isRight(), true);
      result.fold(
        (error) => fail('Expected Right'),
        (products) {
          expect(products.length, 2);
        },
      );
    });

    test('should return empty list when no matches found', () async {
      // Arrange
      when(() => mockRepository.searchProducts('NonExistent'))
          .thenAnswer((_) async => const Right([]));

      // Act
      final result = await usecase('NonExistent');

      // Assert
      expect(result.isRight(), true);
      result.fold(
        (error) => fail('Expected Right'),
        (products) => expect(products.isEmpty, true),
      );
    });

    test('should return error when search fails', () async {
      // Arrange
      when(() => mockRepository.searchProducts('Test'))
          .thenAnswer((_) async => const Left('Search failed'));

      // Act
      final result = await usecase('Test');

      // Assert
      expect(result.isLeft(), true);
    });
  });

  group('ProductEntity', () {
    test('should calculate discount percentage correctly', () {
      const product = ProductEntity(
        id: '1',
        name: 'Test',
        price: 100,
        salePrice: 80,
        categoryId: 'cat',
        stock: 10,
        images: [],
      );

      expect(product.discountPercentage, 20.0);
      expect(product.hasDiscount, true);
      expect(product.effectivePrice, 80);
    });

    test('should return 0 discount when no sale price', () {
      const product = ProductEntity(
        id: '1',
        name: 'Test',
        price: 100,
        categoryId: 'cat',
        stock: 10,
        images: [],
      );

      expect(product.discountPercentage, 0);
      expect(product.hasDiscount, false);
      expect(product.effectivePrice, 100);
    });

    test('should return correct availability status', () {
      const outOfStock = ProductEntity(
        id: '1',
        name: 'Test',
        price: 100,
        categoryId: 'cat',
        stock: 0,
        images: [],
      );

      const limitedStock = ProductEntity(
        id: '2',
        name: 'Test',
        price: 100,
        categoryId: 'cat',
        stock: 3,
        images: [],
      );

      const inStock = ProductEntity(
        id: '3',
        name: 'Test',
        price: 100,
        categoryId: 'cat',
        stock: 50,
        images: [],
      );

      expect(outOfStock.isInStock, false);
      expect(outOfStock.availabilityStatus, 'غير متوفر');

      expect(limitedStock.isInStock, true);
      expect(limitedStock.availabilityStatus, 'كمية محدودة');

      expect(inStock.isInStock, true);
      expect(inStock.availabilityStatus, 'متوفر');
    });

    test('copyWith should create a new instance with updated values', () {
      const original = ProductEntity(
        id: '1',
        name: 'Original',
        price: 100,
        categoryId: 'cat',
        stock: 10,
        images: [],
      );

      final updated = original.copyWith(
        name: 'Updated',
        price: 150,
      );

      expect(updated.id, '1');
      expect(updated.name, 'Updated');
      expect(updated.price, 150);
      expect(updated.categoryId, 'cat');
    });

    test('equality comparison should work correctly', () {
      const product1 = ProductEntity(
        id: '1',
        name: 'Test',
        price: 100,
        categoryId: 'cat',
        stock: 10,
        images: [],
      );

      const product2 = ProductEntity(
        id: '1',
        name: 'Test',
        price: 100,
        categoryId: 'cat',
        stock: 10,
        images: [],
      );

      expect(product1, equals(product2));
    });
  });
}
