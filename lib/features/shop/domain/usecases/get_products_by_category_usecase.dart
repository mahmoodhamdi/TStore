import 'package:dartz/dartz.dart';
import 'package:t_store/core/utils/exceptions/exceptions.dart';
import 'package:t_store/features/shop/domain/entities/product_entity.dart';
import 'package:t_store/features/shop/domain/repository/shop_repository.dart';

class GetProductsByCategoryUsecase {
  final ShopRepository shopRepository;

  GetProductsByCategoryUsecase({required this.shopRepository});

  Future<Either<TExceptions, List<ProductEntity>>> call(
      {required int categoryId}) async {
    return await shopRepository.getProductsByCategory(categoryId: categoryId);
  }
}
