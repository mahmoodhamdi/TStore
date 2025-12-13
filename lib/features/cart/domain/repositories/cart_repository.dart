import 'package:dartz/dartz.dart';
import 'package:t_store/features/cart/domain/entities/cart_item_entity.dart';

abstract class CartRepository {
  Future<Either<String, List<CartItemEntity>>> getCartItems();

  Future<Either<String, CartItemEntity>> addToCart({
    required String productId,
    required int quantity,
    Map<String, dynamic>? selectedAttributes,
  });

  Future<Either<String, CartItemEntity>> updateCartItem({
    required String cartItemId,
    required int quantity,
  });

  Future<Either<String, void>> removeFromCart(String cartItemId);

  Future<Either<String, void>> clearCart();

  Stream<List<CartItemEntity>> get cartStream;
}
