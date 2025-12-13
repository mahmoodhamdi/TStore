import 'package:dartz/dartz.dart';
import 'package:t_store/core/usecases/usecase.dart';
import 'package:t_store/features/cart/domain/entities/cart_item_entity.dart';
import 'package:t_store/features/cart/domain/repositories/cart_repository.dart';

class AddToCartUsecase implements UseCase<CartItemEntity, AddToCartParams> {
  final CartRepository repository;

  AddToCartUsecase(this.repository);

  @override
  Future<Either<String, CartItemEntity>> call(AddToCartParams params) async {
    return await repository.addToCart(
      productId: params.productId,
      quantity: params.quantity,
      selectedAttributes: params.selectedAttributes,
    );
  }
}

class AddToCartParams {
  final String productId;
  final int quantity;
  final Map<String, dynamic>? selectedAttributes;

  AddToCartParams({
    required this.productId,
    this.quantity = 1,
    this.selectedAttributes,
  });
}
