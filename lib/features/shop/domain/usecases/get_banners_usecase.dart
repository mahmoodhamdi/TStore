import 'package:dartz/dartz.dart';
import 'package:t_store/core/usecases/usecase.dart';
import 'package:t_store/features/shop/domain/entities/banner_entity.dart';
import 'package:t_store/features/shop/domain/repositories/banner_repository.dart';

class GetBannersUsecase implements UseCase<List<BannerEntity>, NoParams> {
  final BannerRepository repository;

  GetBannersUsecase(this.repository);

  @override
  Future<Either<String, List<BannerEntity>>> call(NoParams params) async {
    return await repository.getActiveBanners();
  }
}
