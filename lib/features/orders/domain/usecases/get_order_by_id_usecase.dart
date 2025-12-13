import 'package:dartz/dartz.dart';
import 'package:t_store/core/usecases/usecase.dart';
import 'package:t_store/features/orders/domain/entities/order_entity.dart';
import 'package:t_store/features/orders/domain/repositories/order_repository.dart';

class GetOrderByIdUsecase implements UseCase<OrderEntity, String> {
  final OrderRepository repository;

  GetOrderByIdUsecase(this.repository);

  @override
  Future<Either<String, OrderEntity>> call(String id) async {
    return await repository.getOrderById(id);
  }
}
