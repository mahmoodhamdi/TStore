import 'package:dartz/dartz.dart';
import 'package:t_store/features/wishlist/domain/entities/wishlist_item_entity.dart';

abstract class WishlistRepository {
  Future<Either<String, List<WishlistItemEntity>>> getWishlist();

  Future<Either<String, WishlistItemEntity>> addToWishlist(String productId);

  Future<Either<String, void>> removeFromWishlist(String productId);

  Future<Either<String, bool>> isInWishlist(String productId);

  Future<Either<String, void>> toggleWishlist(String productId);
}
