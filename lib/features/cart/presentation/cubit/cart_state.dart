import 'package:equatable/equatable.dart';
import 'package:t_store/features/cart/domain/entities/cart_item_entity.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object?> get props => [];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<CartItemEntity> items;

  const CartLoaded(this.items);

  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);

  double get totalPrice =>
      items.fold(0.0, (sum, item) => sum + item.totalPrice);

  bool get isEmpty => items.isEmpty;

  @override
  List<Object?> get props => [items];
}

class CartError extends CartState {
  final String message;

  const CartError(this.message);

  @override
  List<Object?> get props => [message];
}

class CartItemAdded extends CartState {
  final CartItemEntity item;

  const CartItemAdded(this.item);

  @override
  List<Object?> get props => [item];
}

class CartItemUpdated extends CartState {
  final CartItemEntity item;

  const CartItemUpdated(this.item);

  @override
  List<Object?> get props => [item];
}

class CartItemRemoved extends CartState {
  final String itemId;

  const CartItemRemoved(this.itemId);

  @override
  List<Object?> get props => [itemId];
}

class CartCleared extends CartState {}
