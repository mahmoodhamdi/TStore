import 'package:dartz/dartz.dart';
import 'package:t_store/features/shop/domain/entities/brand_entity.dart';

abstract class BrandRepository {
  Future<Either<String, List<BrandEntity>>> getBrands();

  Future<Either<String, BrandEntity>> getBrandById(String id);

  Future<Either<String, List<BrandEntity>>> getFeaturedBrands();
}
