import 'package:dartz/dartz.dart';
import 'package:t_store/core/utils/exceptions/exceptions.dart';
import 'package:t_store/features/shop/domain/entities/product_entity.dart';
import 'package:t_store/features/shop/domain/repository/shop_repository.dart';

class GetProductsByPriceRangeUsecase {
  final ShopRepository shopRepository;

  GetProductsByPriceRangeUsecase({required this.shopRepository});

  Future<Either<TExceptions, List<ProductEntity>>> call({
     num maxPrice=1000000,
     num minPrice=0,
  }) async {
    return await shopRepository.getProductsByPriceRange(maxPrice: maxPrice, minPrice: minPrice);
  }
}
