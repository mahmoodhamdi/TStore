import 'package:dartz/dartz.dart';
import 'package:t_store/core/supabase/supabase_service.dart';
import 'package:t_store/core/supabase/supabase_tables.dart';
import 'package:t_store/features/orders/data/models/order_model.dart';
import 'package:t_store/features/orders/domain/entities/order_entity.dart';
import 'package:t_store/features/orders/domain/repositories/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final SupabaseService supabaseService;

  OrderRepositoryImpl({required this.supabaseService});

  String get _userId => supabaseService.currentUser?.id ?? '';

  @override
  Future<Either<String, List<OrderEntity>>> getOrders() async {
    try {
      if (_userId.isEmpty) {
        return const Left('يرجى تسجيل الدخول أولاً');
      }

      final response = await supabaseService.client
          .from(SupabaseTables.orders)
          .select('*, order_items(*)')
          .eq('user_id', _userId)
          .order('created_at', ascending: false);

      final orders = (response as List)
          .map((json) => OrderModel.fromJson(json as Map<String, dynamic>))
          .toList();

      return Right(orders);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, OrderEntity>> getOrderById(String id) async {
    try {
      final response = await supabaseService.client
          .from(SupabaseTables.orders)
          .select('*, order_items(*)')
          .eq('id', id)
          .single();

      return Right(OrderModel.fromJson(response));
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, OrderEntity>> createOrder({
    required String addressId,
    required List<CreateOrderItemParams> items,
    required String paymentMethod,
    String? couponCode,
    String? notes,
    double shippingCost = 0,
    double discount = 0,
  }) async {
    try {
      if (_userId.isEmpty) {
        return const Left('يرجى تسجيل الدخول أولاً');
      }

      // Get address for snapshot
      final addressResponse = await supabaseService.client
          .from(SupabaseTables.addresses)
          .select()
          .eq('id', addressId)
          .single();

      // Calculate totals
      final subtotal = items.fold<double>(
        0,
        (sum, item) => sum + (item.price * item.quantity),
      );
      final total = subtotal + shippingCost - discount;

      // Create order
      final orderResponse = await supabaseService.client
          .from(SupabaseTables.orders)
          .insert({
            'user_id': _userId,
            'address_id': addressId,
            'status': 'pending',
            'subtotal': subtotal,
            'shipping_cost': shippingCost,
            'discount': discount,
            'total': total,
            'coupon_code': couponCode,
            'payment_method': paymentMethod,
            'payment_status': 'pending',
            'notes': notes,
            'shipping_address': {
              'full_name': addressResponse['full_name'],
              'phone': addressResponse['phone'],
              'address': addressResponse['address_line1'],
              'city': addressResponse['city'],
              'state': addressResponse['state'],
              'postal_code': addressResponse['postal_code'],
              'country': addressResponse['country'],
            },
          })
          .select()
          .single();

      final orderId = orderResponse['id'] as String;

      // Create order items
      final orderItems = items.map((item) => {
            'order_id': orderId,
            'product_id': item.productId,
            'product_name': item.productName,
            'product_image': item.productImage,
            'price': item.price,
            'quantity': item.quantity,
            'selected_attributes': item.selectedAttributes,
          }).toList();

      await supabaseService.client
          .from(SupabaseTables.orderItems)
          .insert(orderItems);

      // Get full order with items
      return await getOrderById(orderId);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, OrderEntity>> cancelOrder(String orderId) async {
    try {
      // Check if order can be cancelled
      final orderCheck = await supabaseService.client
          .from(SupabaseTables.orders)
          .select('status')
          .eq('id', orderId)
          .single();

      final status = orderCheck['status'] as String;
      if (status != 'pending' && status != 'confirmed') {
        return const Left('لا يمكن إلغاء هذا الطلب');
      }

      await supabaseService.client
          .from(SupabaseTables.orders)
          .update({'status': 'cancelled'})
          .eq('id', orderId);

      return await getOrderById(orderId);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
