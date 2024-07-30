import 'package:dartz/dartz.dart';
import 'package:t_store/core/utils/exceptions/exceptions.dart';
import 'package:t_store/features/shop/domain/entities/category_entity.dart';
import 'package:t_store/features/shop/domain/repository/shop_repository.dart';

class GetCategoriesListUsecase {
  final ShopRepository shopRepository;

  GetCategoriesListUsecase({required this.shopRepository});

  Future<Either<TExceptions, List<CategoryEntity>>> call() async {
    return await shopRepository.getCategoriesList();
  }
}
