import 'package:dartz/dartz.dart';
import 'package:t_store/core/usecases/usecase.dart';
import 'package:t_store/features/orders/domain/entities/order_entity.dart';
import 'package:t_store/features/orders/domain/repositories/order_repository.dart';

class CreateOrderUsecase implements UseCase<OrderEntity, CreateOrderParams> {
  final OrderRepository repository;

  CreateOrderUsecase(this.repository);

  @override
  Future<Either<String, OrderEntity>> call(CreateOrderParams params) async {
    return await repository.createOrder(
      addressId: params.addressId,
      items: params.items,
      paymentMethod: params.paymentMethod,
      couponCode: params.couponCode,
      notes: params.notes,
      shippingCost: params.shippingCost,
      discount: params.discount,
    );
  }
}

class CreateOrderParams {
  final String addressId;
  final List<CreateOrderItemParams> items;
  final String paymentMethod;
  final String? couponCode;
  final String? notes;
  final double shippingCost;
  final double discount;

  CreateOrderParams({
    required this.addressId,
    required this.items,
    required this.paymentMethod,
    this.couponCode,
    this.notes,
    this.shippingCost = 0,
    this.discount = 0,
  });
}
