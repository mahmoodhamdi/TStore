import 'package:equatable/equatable.dart';
import 'package:t_store/features/orders/domain/entities/order_entity.dart';

abstract class OrdersState extends Equatable {
  const OrdersState();

  @override
  List<Object?> get props => [];
}

class OrdersInitial extends OrdersState {}

class OrdersLoading extends OrdersState {}

class OrdersLoaded extends OrdersState {
  final List<OrderEntity> orders;

  const OrdersLoaded(this.orders);

  @override
  List<Object?> get props => [orders];
}

class OrdersError extends OrdersState {
  final String message;

  const OrdersError(this.message);

  @override
  List<Object?> get props => [message];
}

class OrderDetailLoading extends OrdersState {}

class OrderDetailLoaded extends OrdersState {
  final OrderEntity order;

  const OrderDetailLoaded(this.order);

  @override
  List<Object?> get props => [order];
}

class OrderCreating extends OrdersState {}

class OrderCreated extends OrdersState {
  final OrderEntity order;

  const OrderCreated(this.order);

  @override
  List<Object?> get props => [order];
}

class OrderCancelling extends OrdersState {}

class OrderCancelled extends OrdersState {
  final OrderEntity order;

  const OrderCancelled(this.order);

  @override
  List<Object?> get props => [order];
}
