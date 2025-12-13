import 'package:dartz/dartz.dart';
import 'package:t_store/core/supabase/supabase_service.dart';
import 'package:t_store/core/supabase/supabase_tables.dart';
import 'package:t_store/features/shop/data/models/category_model.dart';
import 'package:t_store/features/shop/domain/entities/category_entity.dart';
import 'package:t_store/features/shop/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final SupabaseService supabaseService;

  CategoryRepositoryImpl({required this.supabaseService});

  @override
  Future<Either<String, List<CategoryEntity>>> getCategories() async {
    try {
      final response = await supabaseService.client
          .from(SupabaseTables.categories)
          .select()
          .eq('is_active', true)
          .order('sort_order', ascending: true);

      final categories = (response as List)
          .map((json) => CategoryModel.fromJson(json as Map<String, dynamic>))
          .toList();

      return Right(categories);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, CategoryEntity>> getCategoryById(String id) async {
    try {
      final response = await supabaseService.client
          .from(SupabaseTables.categories)
          .select()
          .eq('id', id)
          .single();

      return Right(CategoryModel.fromJson(response));
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<CategoryEntity>>> getParentCategories() async {
    try {
      final response = await supabaseService.client
          .from(SupabaseTables.categories)
          .select()
          .eq('is_active', true)
          .isFilter('parent_id', null)
          .order('sort_order', ascending: true);

      final categories = (response as List)
          .map((json) => CategoryModel.fromJson(json as Map<String, dynamic>))
          .toList();

      return Right(categories);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<CategoryEntity>>> getSubCategories(
      String parentId) async {
    try {
      final response = await supabaseService.client
          .from(SupabaseTables.categories)
          .select()
          .eq('is_active', true)
          .eq('parent_id', parentId)
          .order('sort_order', ascending: true);

      final categories = (response as List)
          .map((json) => CategoryModel.fromJson(json as Map<String, dynamic>))
          .toList();

      return Right(categories);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
