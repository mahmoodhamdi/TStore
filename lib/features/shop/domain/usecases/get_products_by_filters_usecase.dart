import 'package:dartz/dartz.dart';
import 'package:t_store/core/utils/exceptions/exceptions.dart';
import 'package:t_store/features/shop/domain/entities/product_entity.dart';
import 'package:t_store/features/shop/domain/repository/shop_repository.dart';

class GetProductsByFiltersUsecase {
  final ShopRepository shopRepository;

  GetProductsByFiltersUsecase({required this.shopRepository});

  Future<Either<TExceptions, List<ProductEntity>>> call({
    int? categoryId=0,
    String? search="",
    num? maxPrice=1000000,
    num? minPrice=0,
  }) async {
    return await shopRepository.getProductsByFilters(
      categoryId: categoryId,
      search: search,
      maxPrice: maxPrice,
      minPrice: minPrice,
    );
  }
}
