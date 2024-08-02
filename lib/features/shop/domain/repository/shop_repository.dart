import 'package:dartz/dartz.dart';
import 'package:t_store/core/utils/exceptions/exceptions.dart';
import 'package:t_store/features/shop/domain/entities/product_entity.dart';

abstract class ShopRepository {
  Future<Either<TExceptions, List<ProductEntity>>> getProductsList({
    int page = 0,
    int limit = 10,
  });
  Future<Either<TExceptions, ProductEntity>> getProductById(
      {required int productId});

  Future<Either<TExceptions, List<ProductEntity>>> getProductsByCategory(
      {required String categoryName});

  Future<Either<TExceptions, List<ProductEntity>>> getProductsBySearch(
      {String? search});

  Future<Either<TExceptions, List<ProductEntity>>> getSortedProducts(
      {required String sortBy, required String sortType});
}
