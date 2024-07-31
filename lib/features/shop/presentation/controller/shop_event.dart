part of 'shop_bloc.dart';

abstract class ShopEvent extends Equatable {
  const ShopEvent();

  @override
  List<Object> get props => [];
}

class GetCategoriesListEvent extends ShopEvent {
  const GetCategoriesListEvent();
}

class GetCategoryByIdEvent extends ShopEvent {
  final int id;
  const GetCategoryByIdEvent({required this.id});

  @override
  List<Object> get props => [id];
}

class GetProductsListEvent extends ShopEvent {
  const GetProductsListEvent();
}

class GetProductByIdEvent extends ShopEvent {
  final int id;
  const GetProductByIdEvent({required this.id});

  @override
  List<Object> get props => [id];
}

class GetProductsByCategoryEvent extends ShopEvent {
  final int id;
  const GetProductsByCategoryEvent({required this.id});

  @override
  List<Object> get props => [id];
}

class GetProductsByCategoryAndSearchEvent extends ShopEvent {
  final int id;
  final String? search;
  const GetProductsByCategoryAndSearchEvent({required this.id, this.search});

  @override
  List<Object> get props => [id];
}

class GetProductsBySearchEvent extends ShopEvent {
  final String? search;
  const GetProductsBySearchEvent({this.search});
}

class GetProductsByFiltersEvent extends ShopEvent {
  final int? categoryId;
  final String? search;
  final num? maxPrice;
  final num? minPrice;
  const GetProductsByFiltersEvent(
      {this.categoryId, this.search, this.maxPrice, this.minPrice});
}

class GetProductsByPriceRangeEvent extends ShopEvent {
  final num? maxPrice;
  final num? minPrice;
  const GetProductsByPriceRangeEvent({this.maxPrice, this.minPrice});
}
