import 'package:t_store/features/cart/domain/entities/cart_item_entity.dart';
import 'package:t_store/features/shop/data/models/product_model.dart';

class CartItemModel extends CartItemEntity {
  const CartItemModel({
    required super.id,
    required super.userId,
    required super.productId,
    required super.quantity,
    super.selectedAttributes,
    super.createdAt,
    super.updatedAt,
    super.product,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      productId: json['product_id'] as String,
      quantity: json['quantity'] as int,
      selectedAttributes:
          json['selected_attributes'] as Map<String, dynamic>?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
      product: json['products'] != null
          ? ProductModel.fromJson(json['products'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'product_id': productId,
      'quantity': quantity,
      'selected_attributes': selectedAttributes,
    };
  }

  factory CartItemModel.fromEntity(CartItemEntity entity) {
    return CartItemModel(
      id: entity.id,
      userId: entity.userId,
      productId: entity.productId,
      quantity: entity.quantity,
      selectedAttributes: entity.selectedAttributes,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      product: entity.product,
    );
  }
}
