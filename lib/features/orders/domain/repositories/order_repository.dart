import 'package:dartz/dartz.dart';
import 'package:t_store/features/orders/domain/entities/order_entity.dart';

abstract class OrderRepository {
  Future<Either<String, List<OrderEntity>>> getOrders();

  Future<Either<String, OrderEntity>> getOrderById(String id);

  Future<Either<String, OrderEntity>> createOrder({
    required String addressId,
    required List<CreateOrderItemParams> items,
    required String paymentMethod,
    String? couponCode,
    String? notes,
    double shippingCost,
    double discount,
  });

  Future<Either<String, OrderEntity>> cancelOrder(String orderId);
}

class CreateOrderItemParams {
  final String productId;
  final String productName;
  final String? productImage;
  final double price;
  final int quantity;
  final Map<String, dynamic>? selectedAttributes;

  CreateOrderItemParams({
    required this.productId,
    required this.productName,
    this.productImage,
    required this.price,
    required this.quantity,
    this.selectedAttributes,
  });
}
