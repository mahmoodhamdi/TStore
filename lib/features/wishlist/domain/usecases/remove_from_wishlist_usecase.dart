import 'package:dartz/dartz.dart';
import 'package:t_store/core/usecases/usecase.dart';
import 'package:t_store/features/wishlist/domain/repositories/wishlist_repository.dart';

class RemoveFromWishlistUsecase implements UseCase<void, String> {
  final WishlistRepository repository;

  RemoveFromWishlistUsecase(this.repository);

  @override
  Future<Either<String, void>> call(String productId) async {
    return await repository.removeFromWishlist(productId);
  }
}
