import 'package:dartz/dartz.dart';
import 'package:t_store/features/shop/domain/entities/product_entity.dart';

abstract class ProductRepository {
  Future<Either<String, List<ProductEntity>>> getProducts({
    int page = 0,
    int limit = 20,
    String? categoryId,
    String? brandId,
    bool? isFeatured,
    String? sortBy,
    bool ascending = true,
  });

  Future<Either<String, ProductEntity>> getProductById(String id);

  Future<Either<String, List<ProductEntity>>> searchProducts(String query);

  Future<Either<String, List<ProductEntity>>> getProductsByCategory(
      String categoryId);

  Future<Either<String, List<ProductEntity>>> getProductsByBrand(String brandId);

  Future<Either<String, List<ProductEntity>>> getFeaturedProducts();
}
