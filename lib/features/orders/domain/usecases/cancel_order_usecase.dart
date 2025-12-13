import 'package:dartz/dartz.dart';
import 'package:t_store/core/usecases/usecase.dart';
import 'package:t_store/features/orders/domain/entities/order_entity.dart';
import 'package:t_store/features/orders/domain/repositories/order_repository.dart';

class CancelOrderUsecase implements UseCase<OrderEntity, String> {
  final OrderRepository repository;

  CancelOrderUsecase(this.repository);

  @override
  Future<Either<String, OrderEntity>> call(String orderId) async {
    return await repository.cancelOrder(orderId);
  }
}
