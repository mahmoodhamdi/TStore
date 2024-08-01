import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:t_store/core/utils/constants/api_constants.dart';
import 'package:t_store/core/utils/exceptions/exceptions.dart';
import 'package:t_store/features/shop/data/models/product_model.dart';

abstract class ShopRemoteDataSource {
  Future<Either<TExceptions, List<ProductModel>>> getProductsList(
      {int page = 0, int limit = 10});

  Future<Either<TExceptions, ProductModel>> getProductById(
      {required int productId});

  Future<Either<TExceptions, List<ProductModel>>> getProductsByCategory(
      {required String categoryName});
  Future<Either<TExceptions, List<ProductModel>>> getProductsBySearch(
      {String? search = ""});

  Future<Either<TExceptions, List<ProductModel>>> getSortedProducts({
    required String sortBy,
    required String sortType,
  });
}

class ShopRemoteDataSourceImpl implements ShopRemoteDataSource {
  final Dio dio;
  ShopRemoteDataSourceImpl({required this.dio});
  @override
  Future<Either<TExceptions, ProductModel>> getProductById(
      {required int productId}) async {
    try {
      var response = await dio.get(ApiConstants.getProductById(productId));
      if (response.statusCode == 200) {
        var product = ProductModel.fromJson(response.data);
        return Right(product);
      } else {
        return Left(TExceptions.fromCode(response.statusCode.toString()));
      }
    } on DioException catch (e) {
      return Left(TExceptions.fromCode(e.response.toString()));
    } catch (e) {
      return Left(TExceptions(e.toString()));
    }
  }

  @override
  Future<Either<TExceptions, List<ProductModel>>> getProductsList(
      {int page = 0, int limit = 10}) async {
    try {
      var response =
          await dio.get(ApiConstants.getProducts(page: page, limit: limit));
      if (response.statusCode == 200) {
        var products = (response.data['products'] as List)
            .map((e) => ProductModel.fromJson(e))
            .toList();
        return Right(products);
      } else {
        return Left(TExceptions.fromCode(response.statusCode.toString()));
      }
    } on DioException catch (e) {
      return Left(TExceptions.fromCode(e.response.toString()));
    } catch (e) {
      return Left(TExceptions(e.toString()));
    }
  }

  @override
  Future<Either<TExceptions, List<ProductModel>>> getProductsByCategory(
      {required String categoryName}) async {
    try {
      var response = await dio
          .get(ApiConstants.getProductsByCategory(categoryName: categoryName));
      if (response.statusCode == 200) {
        var products = (response.data['products'] as List)
            .map((e) => ProductModel.fromJson(e))
            .toList();
        return Right(products);
      } else {
        return Left(TExceptions.fromCode(response.statusCode.toString()));
      }
    } on DioException catch (e) {
      return Left(TExceptions.fromCode(e.response.toString()));
    } catch (e) {
      return Left(TExceptions(e.toString()));
    }
  }

  @override
  Future<Either<TExceptions, List<ProductModel>>> getProductsBySearch(
      {String? search}) async {
    try {
      var response =
          await dio.get(ApiConstants.getProductsBySearch(search: search));
      if (response.statusCode == 200) {
        var products = (response.data['products'] as List)
            .map((e) => ProductModel.fromJson(e))
            .toList();
        return Right(products);
      } else {
        return Left(TExceptions.fromCode(response.statusCode.toString()));
      }
    } on DioException catch (e) {
      return Left(TExceptions.fromCode(e.response.toString()));
    } catch (e) {
      return Left(TExceptions(e.toString()));
    }
  }

  @override
  Future<Either<TExceptions, List<ProductModel>>> getSortedProducts(
      {required String sortBy, required String sortType}) async {
    try {
      var response = await dio.get(
          ApiConstants.getSortedProducts(sortBy: sortBy, sortType: sortType));
      if (response.statusCode == 200) {
        var products = (response.data['products'] as List)
            .map((e) => ProductModel.fromJson(e))
            .toList();
        return Right(products);
      } else {
        return Left(TExceptions.fromApi(response.data));
      }
    } on DioException catch (e) {
      return Left(TExceptions.fromCode(e.response.toString()));
    } catch (e) {
      return Left(TExceptions(e.toString()));
    }
  }
}
