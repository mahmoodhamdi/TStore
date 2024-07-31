import 'package:dartz/dartz.dart';
import 'package:t_store/core/utils/exceptions/exceptions.dart';
import 'package:t_store/features/shop/domain/entities/category_entity.dart';
import 'package:t_store/features/shop/domain/repository/shop_repository.dart';

class GetCategoryByIdUsecase {
  final ShopRepository shopRepository;

  GetCategoryByIdUsecase({required this.shopRepository});

  Future<Either<TExceptions, CategoryEntity>> call(
      {required int categoryId}) async {
    return await shopRepository.getCategoryById(categoryId: categoryId);
  }
}
