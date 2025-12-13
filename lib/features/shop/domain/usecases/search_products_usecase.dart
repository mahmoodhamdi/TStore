import 'package:dartz/dartz.dart';
import 'package:t_store/core/usecases/usecase.dart';
import 'package:t_store/features/shop/domain/entities/product_entity.dart';
import 'package:t_store/features/shop/domain/repositories/product_repository.dart';

class SearchProductsUsecase implements UseCase<List<ProductEntity>, String> {
  final ProductRepository repository;

  SearchProductsUsecase(this.repository);

  @override
  Future<Either<String, List<ProductEntity>>> call(String query) async {
    return await repository.searchProducts(query);
  }
}
