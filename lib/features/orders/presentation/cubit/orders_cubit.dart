import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/core/usecases/usecase.dart';
import 'package:t_store/features/orders/domain/repositories/order_repository.dart';
import 'package:t_store/features/orders/domain/usecases/get_orders_usecase.dart';
import 'package:t_store/features/orders/domain/usecases/get_order_by_id_usecase.dart';
import 'package:t_store/features/orders/domain/usecases/create_order_usecase.dart';
import 'package:t_store/features/orders/domain/usecases/cancel_order_usecase.dart';
import 'package:t_store/features/orders/presentation/cubit/orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  final GetOrdersUsecase getOrdersUsecase;
  final GetOrderByIdUsecase getOrderByIdUsecase;
  final CreateOrderUsecase createOrderUsecase;
  final CancelOrderUsecase cancelOrderUsecase;

  OrdersCubit({
    required this.getOrdersUsecase,
    required this.getOrderByIdUsecase,
    required this.createOrderUsecase,
    required this.cancelOrderUsecase,
  }) : super(OrdersInitial());

  Future<void> getOrders() async {
    emit(OrdersLoading());

    final result = await getOrdersUsecase(const NoParams());

    result.fold(
      (error) => emit(OrdersError(error)),
      (orders) => emit(OrdersLoaded(orders)),
    );
  }

  Future<void> getOrderById(String id) async {
    emit(OrderDetailLoading());

    final result = await getOrderByIdUsecase(id);

    result.fold(
      (error) => emit(OrdersError(error)),
      (order) => emit(OrderDetailLoaded(order)),
    );
  }

  Future<void> createOrder({
    required String addressId,
    required List<CreateOrderItemParams> items,
    required String paymentMethod,
    String? couponCode,
    String? notes,
    double shippingCost = 0,
    double discount = 0,
  }) async {
    emit(OrderCreating());

    final result = await createOrderUsecase(CreateOrderParams(
      addressId: addressId,
      items: items,
      paymentMethod: paymentMethod,
      couponCode: couponCode,
      notes: notes,
      shippingCost: shippingCost,
      discount: discount,
    ));

    result.fold(
      (error) => emit(OrdersError(error)),
      (order) => emit(OrderCreated(order)),
    );
  }

  Future<void> cancelOrder(String orderId) async {
    emit(OrderCancelling());

    final result = await cancelOrderUsecase(orderId);

    result.fold(
      (error) => emit(OrdersError(error)),
      (order) => emit(OrderCancelled(order)),
    );
  }
}
