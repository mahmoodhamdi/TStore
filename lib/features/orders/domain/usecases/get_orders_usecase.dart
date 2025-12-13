import 'package:dartz/dartz.dart';
import 'package:t_store/core/usecases/usecase.dart';
import 'package:t_store/features/orders/domain/entities/order_entity.dart';
import 'package:t_store/features/orders/domain/repositories/order_repository.dart';

class GetOrdersUsecase implements UseCase<List<OrderEntity>, NoParams> {
  final OrderRepository repository;

  GetOrdersUsecase(this.repository);

  @override
  Future<Either<String, List<OrderEntity>>> call(NoParams params) async {
    return await repository.getOrders();
  }
}
