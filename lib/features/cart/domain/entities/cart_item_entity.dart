import 'package:equatable/equatable.dart';
import 'package:t_store/features/shop/domain/entities/product_entity.dart';

class CartItemEntity extends Equatable {
  final String id;
  final String userId;
  final String productId;
  final int quantity;
  final Map<String, dynamic>? selectedAttributes;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  // Joined product data
  final ProductEntity? product;

  const CartItemEntity({
    required this.id,
    required this.userId,
    required this.productId,
    required this.quantity,
    this.selectedAttributes,
    this.createdAt,
    this.updatedAt,
    this.product,
  });

  double get totalPrice {
    if (product == null) return 0;
    return product!.effectivePrice * quantity;
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        productId,
        quantity,
        selectedAttributes,
        createdAt,
        updatedAt,
      ];

  CartItemEntity copyWith({
    String? id,
    String? userId,
    String? productId,
    int? quantity,
    Map<String, dynamic>? selectedAttributes,
    DateTime? createdAt,
    DateTime? updatedAt,
    ProductEntity? product,
  }) {
    return CartItemEntity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      selectedAttributes: selectedAttributes ?? this.selectedAttributes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      product: product ?? this.product,
    );
  }
}
