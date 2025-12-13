import 'package:dartz/dartz.dart';
import 'package:t_store/core/usecases/usecase.dart';
import 'package:t_store/features/shop/domain/entities/product_entity.dart';
import 'package:t_store/features/shop/domain/repositories/product_repository.dart';

class GetProductByIdUsecase implements UseCase<ProductEntity, String> {
  final ProductRepository repository;

  GetProductByIdUsecase(this.repository);

  @override
  Future<Either<String, ProductEntity>> call(String id) async {
    return await repository.getProductById(id);
  }
}
