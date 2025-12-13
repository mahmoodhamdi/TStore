import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/core/usecases/usecase.dart';
import 'package:t_store/features/wishlist/domain/entities/wishlist_item_entity.dart';
import 'package:t_store/features/wishlist/domain/usecases/get_wishlist_usecase.dart';
import 'package:t_store/features/wishlist/domain/usecases/add_to_wishlist_usecase.dart';
import 'package:t_store/features/wishlist/domain/usecases/remove_from_wishlist_usecase.dart';
import 'package:t_store/features/wishlist/presentation/cubit/wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  final GetWishlistUsecase getWishlistUsecase;
  final AddToWishlistUsecase addToWishlistUsecase;
  final RemoveFromWishlistUsecase removeFromWishlistUsecase;

  WishlistCubit({
    required this.getWishlistUsecase,
    required this.addToWishlistUsecase,
    required this.removeFromWishlistUsecase,
  }) : super(WishlistInitial());

  List<WishlistItemEntity> _items = [];
  Set<String> _productIds = {};

  Future<void> getWishlist() async {
    emit(WishlistLoading());

    final result = await getWishlistUsecase(const NoParams());

    result.fold(
      (error) => emit(WishlistError(error)),
      (items) {
        _items = items;
        _productIds = items.map((e) => e.productId).toSet();
        emit(WishlistLoaded(items));
      },
    );
  }

  Future<void> addToWishlist(String productId) async {
    final result = await addToWishlistUsecase(productId);

    result.fold(
      (error) => emit(WishlistError(error)),
      (item) {
        emit(WishlistItemAdded(item));
        getWishlist();
      },
    );
  }

  Future<void> removeFromWishlist(String productId) async {
    final result = await removeFromWishlistUsecase(productId);

    result.fold(
      (error) => emit(WishlistError(error)),
      (_) {
        emit(WishlistItemRemoved(productId));
        getWishlist();
      },
    );
  }

  Future<void> toggleWishlist(String productId) async {
    if (isInWishlist(productId)) {
      await removeFromWishlist(productId);
    } else {
      await addToWishlist(productId);
    }
  }

  bool isInWishlist(String productId) {
    return _productIds.contains(productId);
  }

  int get itemCount => _items.length;
}
