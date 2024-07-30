import 'package:dartz/dartz.dart';
import 'package:t_store/core/utils/exceptions/exceptions.dart';
import 'package:t_store/features/shop/domain/entities/category_entity.dart';
import 'package:t_store/features/shop/domain/entities/product_entity.dart';

abstract class ShopRepository {
  Future<Either<TExceptions, List<CategoryEntity>>> getCategoriesList();
  Future<Either<TExceptions, CategoryEntity>> getCategoryById(
      {required int categoryId});
  Future<Either<TExceptions, List<ProductEntity>>> getProductsList();
  Future<Either<TExceptions, ProductEntity>> getProductById({required int id});

  Future<Either<TExceptions, List<ProductEntity>>> getProductsByCategory(
      {required int categoryId});

  Future<Either<TExceptions, List<ProductEntity>>> getProductsByFilters(
      {int? categoryId, String? search, num? maxPrice, num? minPrice});

  Future<Either<TExceptions, List<ProductEntity>>> getProductsByPriceRange(
      {num? maxPrice, num? minPrice});

  Future<Either<TExceptions, List<ProductEntity>>> getProductsBySearch(
      {String? search});

  Future<Either<TExceptions, List<ProductEntity>>>
      getProductsByCategoryAndSearch({int? categoryId, String? search});
}
