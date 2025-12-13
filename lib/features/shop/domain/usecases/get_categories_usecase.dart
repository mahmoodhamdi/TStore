import 'package:dartz/dartz.dart';
import 'package:t_store/core/usecases/usecase.dart';
import 'package:t_store/features/shop/domain/entities/category_entity.dart';
import 'package:t_store/features/shop/domain/repositories/category_repository.dart';

class GetCategoriesUsecase implements UseCase<List<CategoryEntity>, NoParams> {
  final CategoryRepository repository;

  GetCategoriesUsecase(this.repository);

  @override
  Future<Either<String, List<CategoryEntity>>> call(NoParams params) async {
    return await repository.getCategories();
  }
}
