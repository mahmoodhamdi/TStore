import 'package:dartz/dartz.dart';
import 'package:t_store/core/utils/exceptions/exceptions.dart';
import 'package:t_store/features/shop/data/data_sources/shop_remote_data_source.dart';
import 'package:t_store/features/shop/domain/entities/product_entity.dart';
import 'package:t_store/features/shop/domain/repository/shop_repository.dart';

class ShopRepositoryImpl implements ShopRepository {
  final ShopRemoteDataSource remoteDataSource;
  ShopRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<TExceptions, List<ProductEntity>>> getProductsByCategory(
      {required String categoryName}) async {
    return await remoteDataSource.getProductsByCategory(
        categoryName: categoryName);
  }

  @override
  Future<Either<TExceptions, List<ProductEntity>>> getProductsList({
    int page = 0,
    int limit = 10,
  }) async {
    return await remoteDataSource.getProductsList();
  }

  @override
  Future<Either<TExceptions, ProductEntity>> getProductById(
      {required int productId}) async {
    return await remoteDataSource.getProductById(productId: productId);
  }

  @override
  Future<Either<TExceptions, List<ProductEntity>>> getProductsBySearch(
      {String? search}) async {
    return await remoteDataSource.getProductsBySearch(search: search);
  }
  
  @override
  Future<Either<TExceptions, List<ProductEntity>>> getSortedProducts({required String sortBy, required String sortType}) async{
  return await remoteDataSource.getSortedProducts(sortBy: sortBy, sortType: sortType);
  }
}
