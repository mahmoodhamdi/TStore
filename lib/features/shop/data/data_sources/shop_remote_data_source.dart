import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:t_store/core/utils/constants/api_constants.dart';
import 'package:t_store/core/utils/exceptions/exceptions.dart';
import 'package:t_store/features/shop/data/models/category_model.dart';
import 'package:t_store/features/shop/data/models/product_model.dart';

abstract class ShopRemoteDataSource {
  Future<Either<TExceptions, List<ProductModel>>> getProductsList();
  Future<Either<TExceptions, ProductModel>> getProductById(
      {required int productId});

  Future<Either<TExceptions, List<CategoryModel>>> getCategoriesList();
  Future<Either<TExceptions, CategoryModel>> getCategoryById(
      {required int categoryId});

  Future<Either<TExceptions, List<ProductModel>>> getProductsByCategory(
      {required int categoryId});
  Future<Either<TExceptions, List<ProductModel>>> getProductsBySearch(
      {String? search});

  Future<Either<TExceptions, List<ProductModel>>> getProductsByPriceRange(
      {num? maxPrice = 1000000, num? minPrice = 0});

  Future<Either<TExceptions, List<ProductModel>>>
      getProductsByCategoryAndSearch({required int categoryId, String? search});

  Future<Either<TExceptions, List<ProductModel>>> getProductsByFilters(
      {int? categoryId = 0,
      String? search = "",
      num? maxPrice = 10000000,
      num? minPrice = 0});
}

class ShopRemoteDataSourceImpl implements ShopRemoteDataSource {
  final Dio dio;
  ShopRemoteDataSourceImpl({required this.dio});
  @override
  Future<Either<TExceptions, CategoryModel>> getCategoryById(
      {required int categoryId}) async {
    try {
      var response = await dio.get(ApiConstants.getCategoryById(categoryId));
      if (response.statusCode == 200) {
        var category = CategoryModel.fromJson(response.data);
        return Right(category);
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
  Future<Either<TExceptions, List<ProductModel>>> getProductsList() async {
    try {
      var response = await dio.get(ApiConstants.getProducts());
      if (response.statusCode == 200) {
        var products = (response.data as List)
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
  Future<Either<TExceptions, List<CategoryModel>>> getCategoriesList() async {
    try {
      var response = await dio.get(ApiConstants.getCategories());
      if (response.statusCode == 200) {
        var categories = (response.data as List)
            .map((e) => CategoryModel.fromJson(e))
            .toList();
        return Right(categories);
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
      {required int categoryId}) async {
    try {
      var response = await dio
          .get(ApiConstants.getProductsByCategory(categoryId: categoryId));
      if (response.statusCode == 200) {
        var products = (response.data as List)
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
  Future<Either<TExceptions, List<ProductModel>>>
      getProductsByCategoryAndSearch(
          {required int categoryId, String? search}) async {
    try {
      var response = await dio.get(ApiConstants.getProductsByCategoryAndSearch(
          categoryId: categoryId, search: search));
      if (response.statusCode == 200) {
        var products = (response.data as List)
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
        var products = (response.data as List)
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
  Future<Either<TExceptions, List<ProductModel>>> getProductsByFilters(
      {int? categoryId = 0,
      String? search = "",
      num? maxPrice = 1000000,
      num? minPrice = 0}) async {
    try {
      var response = await dio.get(ApiConstants.getProductsByFilters(
          categoryId: categoryId,
          search: search,
          maxPrice: maxPrice,
          minPrice: minPrice));
      if (response.statusCode == 200) {
        var products = (response.data as List)
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
  Future<Either<TExceptions, List<ProductModel>>> getProductsByPriceRange(
      {num? maxPrice = 1000000, num? minPrice = 0}) async {
    try {
      var response = await dio.get(ApiConstants.getProductsByPriceRange(
          maxPrice: maxPrice, minPrice: minPrice));
      if (response.statusCode == 200) {
        var products = (response.data as List)
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
}
