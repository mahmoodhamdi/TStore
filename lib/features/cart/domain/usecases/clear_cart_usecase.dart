import 'package:dartz/dartz.dart';
import 'package:t_store/core/usecases/usecase.dart';
import 'package:t_store/features/cart/domain/repositories/cart_repository.dart';

class ClearCartUsecase implements UseCase<void, NoParams> {
  final CartRepository repository;

  ClearCartUsecase(this.repository);

  @override
  Future<Either<String, void>> call(NoParams params) async {
    return await repository.clearCart();
  }
}
