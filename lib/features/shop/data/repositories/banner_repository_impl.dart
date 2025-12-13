import 'package:dartz/dartz.dart';
import 'package:t_store/core/supabase/supabase_service.dart';
import 'package:t_store/core/supabase/supabase_tables.dart';
import 'package:t_store/features/shop/data/models/banner_model.dart';
import 'package:t_store/features/shop/domain/entities/banner_entity.dart';
import 'package:t_store/features/shop/domain/repositories/banner_repository.dart';

class BannerRepositoryImpl implements BannerRepository {
  final SupabaseService supabaseService;

  BannerRepositoryImpl({required this.supabaseService});

  @override
  Future<Either<String, List<BannerEntity>>> getBanners() async {
    try {
      final response = await supabaseService.client
          .from(SupabaseTables.banners)
          .select()
          .order('sort_order', ascending: true);

      final banners = (response as List)
          .map((json) => BannerModel.fromJson(json as Map<String, dynamic>))
          .toList();

      return Right(banners);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<BannerEntity>>> getActiveBanners() async {
    try {
      final now = DateTime.now().toIso8601String();

      final response = await supabaseService.client
          .from(SupabaseTables.banners)
          .select()
          .eq('is_active', true)
          .or('start_date.is.null,start_date.lte.$now')
          .or('end_date.is.null,end_date.gte.$now')
          .order('sort_order', ascending: true);

      final banners = (response as List)
          .map((json) => BannerModel.fromJson(json as Map<String, dynamic>))
          .toList();

      return Right(banners);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
