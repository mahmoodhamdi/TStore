import 'package:equatable/equatable.dart';
import 'package:t_store/features/wishlist/domain/entities/wishlist_item_entity.dart';

abstract class WishlistState extends Equatable {
  const WishlistState();

  @override
  List<Object?> get props => [];
}

class WishlistInitial extends WishlistState {}

class WishlistLoading extends WishlistState {}

class WishlistLoaded extends WishlistState {
  final List<WishlistItemEntity> items;
  final Set<String> productIds;

  WishlistLoaded(this.items)
      : productIds = items.map((e) => e.productId).toSet();

  bool isInWishlist(String productId) => productIds.contains(productId);

  @override
  List<Object?> get props => [items];
}

class WishlistError extends WishlistState {
  final String message;

  const WishlistError(this.message);

  @override
  List<Object?> get props => [message];
}

class WishlistItemAdded extends WishlistState {
  final WishlistItemEntity item;

  const WishlistItemAdded(this.item);

  @override
  List<Object?> get props => [item];
}

class WishlistItemRemoved extends WishlistState {
  final String productId;

  const WishlistItemRemoved(this.productId);

  @override
  List<Object?> get props => [productId];
}
