import 'package:dartz/dartz.dart';
import 'package:t_store/core/supabase/supabase_service.dart';
import 'package:t_store/core/supabase/supabase_tables.dart';
import 'package:t_store/features/shop/data/models/product_model.dart';
import 'package:t_store/features/shop/domain/entities/product_entity.dart';
import 'package:t_store/features/shop/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final SupabaseService supabaseService;

  ProductRepositoryImpl({required this.supabaseService});

  @override
  Future<Either<String, List<ProductEntity>>> getProducts({
    int page = 0,
    int limit = 20,
    String? categoryId,
    String? brandId,
    bool? isFeatured,
    String? sortBy,
    bool ascending = true,
  }) async {
    try {
      var filterQuery = supabaseService.client
          .from(SupabaseTables.products)
          .select('*, categories(name), brands(name)')
          .eq('is_active', true);

      if (categoryId != null) {
        filterQuery = filterQuery.eq('category_id', categoryId);
      }

      if (brandId != null) {
        filterQuery = filterQuery.eq('brand_id', brandId);
      }

      if (isFeatured != null) {
        filterQuery = filterQuery.eq('is_featured', isFeatured);
      }

      final orderColumn = sortBy ?? 'created_at';
      final from = page * limit;
      final to = from + limit - 1;

      final response = await filterQuery
          .order(orderColumn, ascending: ascending)
          .range(from, to);

      final products = (response as List)
          .map((json) => ProductModel.fromJson(json as Map<String, dynamic>))
          .toList();

      return Right(products);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, ProductEntity>> getProductById(String id) async {
    try {
      final response = await supabaseService.client
          .from(SupabaseTables.products)
          .select('*, categories(name), brands(name)')
          .eq('id', id)
          .single();

      return Right(ProductModel.fromJson(response));
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<ProductEntity>>> searchProducts(
      String query) async {
    try {
      final response = await supabaseService.client
          .from(SupabaseTables.products)
          .select('*, categories(name), brands(name)')
          .eq('is_active', true)
          .or('name.ilike.%$query%,description.ilike.%$query%')
          .limit(50);

      final products = (response as List)
          .map((json) => ProductModel.fromJson(json as Map<String, dynamic>))
          .toList();

      return Right(products);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<ProductEntity>>> getProductsByCategory(
      String categoryId) async {
    try {
      final response = await supabaseService.client
          .from(SupabaseTables.products)
          .select('*, categories(name), brands(name)')
          .eq('is_active', true)
          .eq('category_id', categoryId)
          .order('created_at', ascending: false);

      final products = (response as List)
          .map((json) => ProductModel.fromJson(json as Map<String, dynamic>))
          .toList();

      return Right(products);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<ProductEntity>>> getProductsByBrand(
      String brandId) async {
    try {
      final response = await supabaseService.client
          .from(SupabaseTables.products)
          .select('*, categories(name), brands(name)')
          .eq('is_active', true)
          .eq('brand_id', brandId)
          .order('created_at', ascending: false);

      final products = (response as List)
          .map((json) => ProductModel.fromJson(json as Map<String, dynamic>))
          .toList();

      return Right(products);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<ProductEntity>>> getFeaturedProducts() async {
    try {
      final response = await supabaseService.client
          .from(SupabaseTables.products)
          .select('*, categories(name), brands(name)')
          .eq('is_active', true)
          .eq('is_featured', true)
          .order('created_at', ascending: false)
          .limit(20);

      final products = (response as List)
          .map((json) => ProductModel.fromJson(json as Map<String, dynamic>))
          .toList();

      return Right(products);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
