part of 'shop_bloc.dart';

abstract class ShopState extends Equatable {
  const ShopState();

  @override
  List<Object> get props => [];
}

class ShopInitial extends ShopState {}

class ShopLoadingState extends ShopState {}

class ShopProductsLoadedState extends ShopState {
  final List<ProductEntity> products;

  const ShopProductsLoadedState(this.products);

  @override
  List<Object> get props => [products];
}

class ShopCategoriesLoadedState extends ShopState {
  final List<CategoryEntity> categories;

  const ShopCategoriesLoadedState(this.categories);

  @override
  List<Object> get props => [categories];
}

class ShopErrorState extends ShopState {
  final TExceptions exception;

  const ShopErrorState(this.exception);

  @override
  List<Object> get props => [exception];
}

class ShopProductLoadedState extends ShopState {
  final ProductEntity product;

  const ShopProductLoadedState(this.product);

  @override
  List<Object> get props => [product];
}

class ShopCategoryLoadedState extends ShopState {
  final CategoryEntity category;

  const ShopCategoryLoadedState(this.category);

  @override
  List<Object> get props => [category];
}
