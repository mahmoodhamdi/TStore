import 'package:dartz/dartz.dart';
import 'package:t_store/features/shop/domain/entities/banner_entity.dart';

abstract class BannerRepository {
  Future<Either<String, List<BannerEntity>>> getBanners();

  Future<Either<String, List<BannerEntity>>> getActiveBanners();
}
