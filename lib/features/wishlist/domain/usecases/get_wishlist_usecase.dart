import 'package:dartz/dartz.dart';
import 'package:t_store/core/usecases/usecase.dart';
import 'package:t_store/features/wishlist/domain/entities/wishlist_item_entity.dart';
import 'package:t_store/features/wishlist/domain/repositories/wishlist_repository.dart';

class GetWishlistUsecase
    implements UseCase<List<WishlistItemEntity>, NoParams> {
  final WishlistRepository repository;

  GetWishlistUsecase(this.repository);

  @override
  Future<Either<String, List<WishlistItemEntity>>> call(NoParams params) async {
    return await repository.getWishlist();
  }
}
