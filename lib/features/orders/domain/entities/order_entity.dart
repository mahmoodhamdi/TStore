import 'package:equatable/equatable.dart';

enum OrderStatus {
  pending,
  confirmed,
  processing,
  shipped,
  delivered,
  cancelled,
  refunded,
}

class OrderEntity extends Equatable {
  final String id;
  final String userId;
  final String? addressId;
  final OrderStatus status;
  final double subtotal;
  final double shippingCost;
  final double discount;
  final double total;
  final String? couponCode;
  final String paymentMethod;
  final String? paymentStatus;
  final String? notes;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  // Joined data
  final List<OrderItemEntity> items;
  final AddressSnapshotEntity? shippingAddress;

  const OrderEntity({
    required this.id,
    required this.userId,
    this.addressId,
    required this.status,
    required this.subtotal,
    this.shippingCost = 0,
    this.discount = 0,
    required this.total,
    this.couponCode,
    required this.paymentMethod,
    this.paymentStatus,
    this.notes,
    this.createdAt,
    this.updatedAt,
    this.items = const [],
    this.shippingAddress,
  });

  String get statusText {
    switch (status) {
      case OrderStatus.pending:
        return 'قيد الانتظار';
      case OrderStatus.confirmed:
        return 'تم التأكيد';
      case OrderStatus.processing:
        return 'قيد التجهيز';
      case OrderStatus.shipped:
        return 'تم الشحن';
      case OrderStatus.delivered:
        return 'تم التوصيل';
      case OrderStatus.cancelled:
        return 'ملغي';
      case OrderStatus.refunded:
        return 'مسترجع';
    }
  }

  bool get canCancel =>
      status == OrderStatus.pending || status == OrderStatus.confirmed;

  @override
  List<Object?> get props => [
        id,
        userId,
        addressId,
        status,
        subtotal,
        shippingCost,
        discount,
        total,
        couponCode,
        paymentMethod,
        paymentStatus,
        notes,
        createdAt,
        updatedAt,
      ];
}

class OrderItemEntity extends Equatable {
  final String id;
  final String orderId;
  final String productId;
  final String productName;
  final String? productImage;
  final double price;
  final int quantity;
  final Map<String, dynamic>? selectedAttributes;

  const OrderItemEntity({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.productName,
    this.productImage,
    required this.price,
    required this.quantity,
    this.selectedAttributes,
  });

  double get totalPrice => price * quantity;

  @override
  List<Object?> get props => [
        id,
        orderId,
        productId,
        productName,
        productImage,
        price,
        quantity,
        selectedAttributes,
      ];
}

class AddressSnapshotEntity extends Equatable {
  final String fullName;
  final String phone;
  final String address;
  final String city;
  final String? state;
  final String? postalCode;
  final String country;

  const AddressSnapshotEntity({
    required this.fullName,
    required this.phone,
    required this.address,
    required this.city,
    this.state,
    this.postalCode,
    required this.country,
  });

  String get fullAddress => '$address, $city${state != null ? ', $state' : ''}, $country';

  @override
  List<Object?> get props =>
      [fullName, phone, address, city, state, postalCode, country];
}
