part of 'shop_cubit.dart';

abstract class ShopState extends Equatable {
  const ShopState();

  @override
  List<Object> get props => [];
}

class ShopInitial extends ShopState {}

class ShopLoading extends ShopState {}

class ShopProductsLoaded extends ShopState {
  final List<ProductEntity> productsList;
  const ShopProductsLoaded({required this.productsList});

  @override
  List<Object> get props => [productsList];
}

class ShopProductLoaded extends ShopState {
  final ProductEntity product;
  const ShopProductLoaded({required this.product});

  @override
  List<Object> get props => [product];
}

class ShopError extends ShopState {
  final TExceptions error;
  const ShopError({required this.error});
}
