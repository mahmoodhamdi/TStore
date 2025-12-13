import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/core/usecases/usecase.dart';
import 'package:t_store/features/cart/domain/entities/cart_item_entity.dart';
import 'package:t_store/features/cart/domain/usecases/get_cart_items_usecase.dart';
import 'package:t_store/features/cart/domain/usecases/add_to_cart_usecase.dart';
import 'package:t_store/features/cart/domain/usecases/update_cart_item_usecase.dart';
import 'package:t_store/features/cart/domain/usecases/remove_from_cart_usecase.dart';
import 'package:t_store/features/cart/domain/usecases/clear_cart_usecase.dart';
import 'package:t_store/features/cart/presentation/cubit/cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final GetCartItemsUsecase getCartItemsUsecase;
  final AddToCartUsecase addToCartUsecase;
  final UpdateCartItemUsecase updateCartItemUsecase;
  final RemoveFromCartUsecase removeFromCartUsecase;
  final ClearCartUsecase clearCartUsecase;

  CartCubit({
    required this.getCartItemsUsecase,
    required this.addToCartUsecase,
    required this.updateCartItemUsecase,
    required this.removeFromCartUsecase,
    required this.clearCartUsecase,
  }) : super(CartInitial());

  List<CartItemEntity> _items = [];

  Future<void> getCartItems() async {
    emit(CartLoading());

    final result = await getCartItemsUsecase(const NoParams());

    result.fold(
      (error) => emit(CartError(error)),
      (items) {
        _items = items;
        emit(CartLoaded(items));
      },
    );
  }

  Future<void> addToCart({
    required String productId,
    int quantity = 1,
    Map<String, dynamic>? selectedAttributes,
  }) async {
    final result = await addToCartUsecase(AddToCartParams(
      productId: productId,
      quantity: quantity,
      selectedAttributes: selectedAttributes,
    ));

    result.fold(
      (error) => emit(CartError(error)),
      (item) {
        emit(CartItemAdded(item));
        getCartItems();
      },
    );
  }

  Future<void> updateCartItem({
    required String cartItemId,
    required int quantity,
  }) async {
    final result = await updateCartItemUsecase(UpdateCartItemParams(
      cartItemId: cartItemId,
      quantity: quantity,
    ));

    result.fold(
      (error) {
        if (error == 'تم إزالة المنتج من السلة') {
          emit(CartItemRemoved(cartItemId));
        } else {
          emit(CartError(error));
        }
        getCartItems();
      },
      (item) {
        emit(CartItemUpdated(item));
        getCartItems();
      },
    );
  }

  Future<void> incrementQuantity(String cartItemId) async {
    final item = _items.firstWhere(
      (item) => item.id == cartItemId,
      orElse: () => throw Exception('Item not found'),
    );
    await updateCartItem(
      cartItemId: cartItemId,
      quantity: item.quantity + 1,
    );
  }

  Future<void> decrementQuantity(String cartItemId) async {
    final item = _items.firstWhere(
      (item) => item.id == cartItemId,
      orElse: () => throw Exception('Item not found'),
    );
    await updateCartItem(
      cartItemId: cartItemId,
      quantity: item.quantity - 1,
    );
  }

  Future<void> removeFromCart(String cartItemId) async {
    final result = await removeFromCartUsecase(cartItemId);

    result.fold(
      (error) => emit(CartError(error)),
      (_) {
        emit(CartItemRemoved(cartItemId));
        getCartItems();
      },
    );
  }

  Future<void> clearCart() async {
    final result = await clearCartUsecase(const NoParams());

    result.fold(
      (error) => emit(CartError(error)),
      (_) {
        _items = [];
        emit(CartCleared());
        emit(CartLoaded([]));
      },
    );
  }

  int get itemCount {
    if (state is CartLoaded) {
      return (state as CartLoaded).itemCount;
    }
    return 0;
  }

  double get totalPrice {
    if (state is CartLoaded) {
      return (state as CartLoaded).totalPrice;
    }
    return 0;
  }
}
