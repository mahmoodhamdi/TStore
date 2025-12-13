import 'package:equatable/equatable.dart';
import 'package:t_store/features/shop/domain/entities/product_entity.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object?> get props => [];
}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsLoaded extends ProductsState {
  final List<ProductEntity> products;
  final bool hasReachedMax;
  final int currentPage;

  const ProductsLoaded({
    required this.products,
    this.hasReachedMax = false,
    this.currentPage = 0,
  });

  @override
  List<Object?> get props => [products, hasReachedMax, currentPage];

  ProductsLoaded copyWith({
    List<ProductEntity>? products,
    bool? hasReachedMax,
    int? currentPage,
  }) {
    return ProductsLoaded(
      products: products ?? this.products,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}

class ProductsError extends ProductsState {
  final String message;

  const ProductsError(this.message);

  @override
  List<Object?> get props => [message];
}

// Single Product States
class ProductDetailLoading extends ProductsState {}

class ProductDetailLoaded extends ProductsState {
  final ProductEntity product;

  const ProductDetailLoaded(this.product);

  @override
  List<Object?> get props => [product];
}

class ProductDetailError extends ProductsState {
  final String message;

  const ProductDetailError(this.message);

  @override
  List<Object?> get props => [message];
}

// Search States
class ProductsSearching extends ProductsState {}

class ProductsSearchResult extends ProductsState {
  final List<ProductEntity> products;
  final String query;

  const ProductsSearchResult({
    required this.products,
    required this.query,
  });

  @override
  List<Object?> get props => [products, query];
}
