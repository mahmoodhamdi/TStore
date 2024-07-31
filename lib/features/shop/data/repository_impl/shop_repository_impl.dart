import 'package:dartz/dartz.dart';
import 'package:t_store/core/utils/exceptions/exceptions.dart';
import 'package:t_store/features/shop/data/data_sources/shop_remote_data_source.dart';
import 'package:t_store/features/shop/domain/entities/category_entity.dart';
import 'package:t_store/features/shop/domain/entities/product_entity.dart';
import 'package:t_store/features/shop/domain/repository/shop_repository.dart';

class ShopRepositoryImpl implements ShopRepository {
  final ShopRemoteDataSource remoteDataSource;
  ShopRepositoryImpl({required this.remoteDataSource});
  @override
  Future<Either<TExceptions, List<CategoryEntity>>> getCategoriesList() async {
    return await remoteDataSource.getCategoriesList();
  }

  @override
  Future<Either<TExceptions, CategoryEntity>> getCategoryById(
      {required int categoryId}) async {
    return await remoteDataSource.getCategoryById(categoryId: categoryId);
  }

  @override
  Future<Either<TExceptions, List<ProductEntity>>> getProductsByCategory(
      {required int categoryId}) async {
    return await remoteDataSource.getProductsByCategory(categoryId: categoryId);
  }

  @override
  Future<Either<TExceptions, List<ProductEntity>>> getProductsList() async {
    return await remoteDataSource.getProductsList();
  }

  @override
  Future<Either<TExceptions, List<ProductEntity>>>
      getProductsByCategoryAndSearch(
          {required int categoryId, String? search}) async {
    return await remoteDataSource.getProductsByCategoryAndSearch(
        categoryId: categoryId, search: search);
  }

  @override
  Future<Either<TExceptions, List<ProductEntity>>> getProductsByFilters(
      {int? categoryId, String? search, num? maxPrice, num? minPrice}) async {
    return await remoteDataSource.getProductsByFilters(
        categoryId: categoryId,
        search: search,
        maxPrice: maxPrice,
        minPrice: minPrice);
  }

  @override
  Future<Either<TExceptions, List<ProductEntity>>> getProductsByPriceRange(
      {num? maxPrice = 1000000, num? minPrice = 0}) async {
    return await remoteDataSource.getProductsByPriceRange(
        maxPrice: maxPrice, minPrice: minPrice);
  }

  @override
  Future<Either<TExceptions, ProductEntity>> getProductById({required int productId}) async{
   
    return await remoteDataSource.getProductById(productId: productId);
  }

  @override
  Future<Either<TExceptions, List<ProductEntity>>> getProductsBySearch(
      {String? search}) async {
    return await remoteDataSource.getProductsBySearch(search: search);
  }
}
