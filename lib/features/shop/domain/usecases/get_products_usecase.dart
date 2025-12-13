import 'package:dartz/dartz.dart';
import 'package:t_store/core/usecases/usecase.dart';
import 'package:t_store/features/shop/domain/entities/product_entity.dart';
import 'package:t_store/features/shop/domain/repositories/product_repository.dart';

class GetProductsUsecase implements UseCase<List<ProductEntity>, GetProductsParams> {
  final ProductRepository repository;

  GetProductsUsecase(this.repository);

  @override
  Future<Either<String, List<ProductEntity>>> call(GetProductsParams params) async {
    return await repository.getProducts(
      page: params.page,
      limit: params.limit,
      categoryId: params.categoryId,
      brandId: params.brandId,
      isFeatured: params.isFeatured,
      sortBy: params.sortBy,
      ascending: params.ascending,
    );
  }
}

class GetProductsParams {
  final int page;
  final int limit;
  final String? categoryId;
  final String? brandId;
  final bool? isFeatured;
  final String? sortBy;
  final bool ascending;

  GetProductsParams({
    this.page = 0,
    this.limit = 20,
    this.categoryId,
    this.brandId,
    this.isFeatured,
    this.sortBy,
    this.ascending = true,
  });
}
