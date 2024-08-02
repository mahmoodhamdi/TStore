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

class ShopSortedProductsLoaded extends ShopState {
  final List<ProductEntity> productsList;
  const ShopSortedProductsLoaded({required this.productsList});
}

class ShopSearchProductsLoaded extends ShopState {
  final List<ProductEntity> productsList;
  const ShopSearchProductsLoaded({required this.productsList});
}
class ShopCategoryProductsLoaded extends ShopState {
  final List<ProductEntity> productsList;
  const ShopCategoryProductsLoaded({required this.productsList});
}
class ShopError extends ShopState {
  final TExceptions error;
  const ShopError({required this.error});
}
