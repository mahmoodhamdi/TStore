import 'package:dartz/dartz.dart';
import 'package:t_store/core/usecases/usecase.dart';
import 'package:t_store/features/cart/domain/entities/cart_item_entity.dart';
import 'package:t_store/features/cart/domain/repositories/cart_repository.dart';

class GetCartItemsUsecase implements UseCase<List<CartItemEntity>, NoParams> {
  final CartRepository repository;

  GetCartItemsUsecase(this.repository);

  @override
  Future<Either<String, List<CartItemEntity>>> call(NoParams params) async {
    return await repository.getCartItems();
  }
}
