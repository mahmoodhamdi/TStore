import 'package:dartz/dartz.dart';
import 'package:t_store/core/usecases/usecase.dart';
import 'package:t_store/features/shop/domain/entities/brand_entity.dart';
import 'package:t_store/features/shop/domain/repositories/brand_repository.dart';

class GetBrandsUsecase implements UseCase<List<BrandEntity>, NoParams> {
  final BrandRepository repository;

  GetBrandsUsecase(this.repository);

  @override
  Future<Either<String, List<BrandEntity>>> call(NoParams params) async {
    return await repository.getBrands();
  }
}
