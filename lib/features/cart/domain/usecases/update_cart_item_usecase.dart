import 'package:dartz/dartz.dart';
import 'package:t_store/core/usecases/usecase.dart';
import 'package:t_store/features/cart/domain/entities/cart_item_entity.dart';
import 'package:t_store/features/cart/domain/repositories/cart_repository.dart';

class UpdateCartItemUsecase
    implements UseCase<CartItemEntity, UpdateCartItemParams> {
  final CartRepository repository;

  UpdateCartItemUsecase(this.repository);

  @override
  Future<Either<String, CartItemEntity>> call(
      UpdateCartItemParams params) async {
    return await repository.updateCartItem(
      cartItemId: params.cartItemId,
      quantity: params.quantity,
    );
  }
}

class UpdateCartItemParams {
  final String cartItemId;
  final int quantity;

  UpdateCartItemParams({
    required this.cartItemId,
    required this.quantity,
  });
}
