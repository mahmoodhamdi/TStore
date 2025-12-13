import 'package:t_store/features/orders/domain/entities/order_entity.dart';

class OrderModel extends OrderEntity {
  const OrderModel({
    required super.id,
    required super.userId,
    super.addressId,
    required super.status,
    required super.subtotal,
    super.shippingCost,
    super.discount,
    required super.total,
    super.couponCode,
    required super.paymentMethod,
    super.paymentStatus,
    super.notes,
    super.createdAt,
    super.updatedAt,
    super.items,
    super.shippingAddress,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      addressId: json['address_id'] as String?,
      status: _parseStatus(json['status'] as String?),
      subtotal: (json['subtotal'] as num).toDouble(),
      shippingCost: (json['shipping_cost'] as num?)?.toDouble() ?? 0,
      discount: (json['discount'] as num?)?.toDouble() ?? 0,
      total: (json['total'] as num).toDouble(),
      couponCode: json['coupon_code'] as String?,
      paymentMethod: json['payment_method'] as String? ?? 'cash',
      paymentStatus: json['payment_status'] as String?,
      notes: json['notes'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
      items: json['order_items'] != null
          ? (json['order_items'] as List)
              .map((e) => OrderItemModel.fromJson(e as Map<String, dynamic>))
              .toList()
          : [],
      shippingAddress: json['shipping_address'] != null
          ? AddressSnapshotModel.fromJson(
              json['shipping_address'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'address_id': addressId,
      'status': status.name,
      'subtotal': subtotal,
      'shipping_cost': shippingCost,
      'discount': discount,
      'total': total,
      'coupon_code': couponCode,
      'payment_method': paymentMethod,
      'payment_status': paymentStatus,
      'notes': notes,
      'shipping_address': shippingAddress != null
          ? {
              'full_name': shippingAddress!.fullName,
              'phone': shippingAddress!.phone,
              'address': shippingAddress!.address,
              'city': shippingAddress!.city,
              'state': shippingAddress!.state,
              'postal_code': shippingAddress!.postalCode,
              'country': shippingAddress!.country,
            }
          : null,
    };
  }

  static OrderStatus _parseStatus(String? status) {
    switch (status) {
      case 'pending':
        return OrderStatus.pending;
      case 'confirmed':
        return OrderStatus.confirmed;
      case 'processing':
        return OrderStatus.processing;
      case 'shipped':
        return OrderStatus.shipped;
      case 'delivered':
        return OrderStatus.delivered;
      case 'cancelled':
        return OrderStatus.cancelled;
      case 'refunded':
        return OrderStatus.refunded;
      default:
        return OrderStatus.pending;
    }
  }
}

class OrderItemModel extends OrderItemEntity {
  const OrderItemModel({
    required super.id,
    required super.orderId,
    required super.productId,
    required super.productName,
    super.productImage,
    required super.price,
    required super.quantity,
    super.selectedAttributes,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      id: json['id'] as String,
      orderId: json['order_id'] as String,
      productId: json['product_id'] as String,
      productName: json['product_name'] as String,
      productImage: json['product_image'] as String?,
      price: (json['price'] as num).toDouble(),
      quantity: json['quantity'] as int,
      selectedAttributes:
          json['selected_attributes'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'order_id': orderId,
      'product_id': productId,
      'product_name': productName,
      'product_image': productImage,
      'price': price,
      'quantity': quantity,
      'selected_attributes': selectedAttributes,
    };
  }
}

class AddressSnapshotModel extends AddressSnapshotEntity {
  const AddressSnapshotModel({
    required super.fullName,
    required super.phone,
    required super.address,
    required super.city,
    super.state,
    super.postalCode,
    required super.country,
  });

  factory AddressSnapshotModel.fromJson(Map<String, dynamic> json) {
    return AddressSnapshotModel(
      fullName: json['full_name'] as String,
      phone: json['phone'] as String,
      address: json['address'] as String,
      city: json['city'] as String,
      state: json['state'] as String?,
      postalCode: json['postal_code'] as String?,
      country: json['country'] as String,
    );
  }
}
