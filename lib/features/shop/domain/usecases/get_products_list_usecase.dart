import 'package:dartz/dartz.dart';
import 'package:t_store/core/utils/exceptions/exceptions.dart';
import 'package:t_store/features/shop/domain/entities/product_entity.dart';
import 'package:t_store/features/shop/domain/repository/shop_repository.dart';

class GetProductsListUsecase {
  final ShopRepository shopRepository;

  GetProductsListUsecase({required this.shopRepository});
  Future<Either<TExceptions, List<ProductEntity>>> call(
      {int page = 0, int limit = 10}) async {
    return await shopRepository.getProductsList(page: page, limit: limit);
  }
}
