import 'package:dartz/dartz.dart';
import 'package:t_store/core/usecases/usecase.dart';
import 'package:t_store/features/cart/domain/repositories/cart_repository.dart';

class RemoveFromCartUsecase implements UseCase<void, String> {
  final CartRepository repository;

  RemoveFromCartUsecase(this.repository);

  @override
  Future<Either<String, void>> call(String cartItemId) async {
    return await repository.removeFromCart(cartItemId);
  }
}
