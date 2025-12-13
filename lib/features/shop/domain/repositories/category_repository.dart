import 'package:dartz/dartz.dart';
import 'package:t_store/features/shop/domain/entities/category_entity.dart';

abstract class CategoryRepository {
  Future<Either<String, List<CategoryEntity>>> getCategories();

  Future<Either<String, CategoryEntity>> getCategoryById(String id);

  Future<Either<String, List<CategoryEntity>>> getParentCategories();

  Future<Either<String, List<CategoryEntity>>> getSubCategories(
      String parentId);
}
