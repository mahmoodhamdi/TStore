import 'package:equatable/equatable.dart';
import 'package:t_store/features/shop/domain/entities/product_entity.dart';

class WishlistItemEntity extends Equatable {
  final String id;
  final String userId;
  final String productId;
  final DateTime? createdAt;

  // Joined product data
  final ProductEntity? product;

  const WishlistItemEntity({
    required this.id,
    required this.userId,
    required this.productId,
    this.createdAt,
    this.product,
  });

  @override
  List<Object?> get props => [id, userId, productId, createdAt];

  WishlistItemEntity copyWith({
    String? id,
    String? userId,
    String? productId,
    DateTime? createdAt,
    ProductEntity? product,
  }) {
    return WishlistItemEntity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      productId: productId ?? this.productId,
      createdAt: createdAt ?? this.createdAt,
      product: product ?? this.product,
    );
  }
}
