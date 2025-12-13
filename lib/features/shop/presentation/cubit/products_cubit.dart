import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/features/shop/domain/entities/product_entity.dart';
import 'package:t_store/features/shop/domain/usecases/get_products_usecase.dart';
import 'package:t_store/features/shop/domain/usecases/get_product_by_id_usecase.dart';
import 'package:t_store/features/shop/domain/usecases/search_products_usecase.dart';
import 'package:t_store/features/shop/presentation/cubit/products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final GetProductsUsecase getProductsUsecase;
  final GetProductByIdUsecase getProductByIdUsecase;
  final SearchProductsUsecase searchProductsUsecase;

  ProductsCubit({
    required this.getProductsUsecase,
    required this.getProductByIdUsecase,
    required this.searchProductsUsecase,
  }) : super(ProductsInitial());

  List<ProductEntity> _allProducts = [];
  int _currentPage = 0;
  static const int _limit = 20;

  Future<void> getProducts({
    String? categoryId,
    String? brandId,
    bool? isFeatured,
    String? sortBy,
    bool ascending = true,
    bool refresh = false,
  }) async {
    if (refresh) {
      _currentPage = 0;
      _allProducts = [];
    }

    if (_currentPage == 0) {
      emit(ProductsLoading());
    }

    final result = await getProductsUsecase(GetProductsParams(
      page: _currentPage,
      limit: _limit,
      categoryId: categoryId,
      brandId: brandId,
      isFeatured: isFeatured,
      sortBy: sortBy,
      ascending: ascending,
    ));

    result.fold(
      (error) => emit(ProductsError(error)),
      (products) {
        _allProducts = [..._allProducts, ...products];
        _currentPage++;
        emit(ProductsLoaded(
          products: _allProducts,
          hasReachedMax: products.length < _limit,
          currentPage: _currentPage,
        ));
      },
    );
  }

  Future<void> loadMoreProducts({
    String? categoryId,
    String? brandId,
    bool? isFeatured,
    String? sortBy,
    bool ascending = true,
  }) async {
    if (state is ProductsLoaded) {
      final currentState = state as ProductsLoaded;
      if (currentState.hasReachedMax) return;

      await getProducts(
        categoryId: categoryId,
        brandId: brandId,
        isFeatured: isFeatured,
        sortBy: sortBy,
        ascending: ascending,
      );
    }
  }

  Future<void> getProductById(String id) async {
    emit(ProductDetailLoading());

    final result = await getProductByIdUsecase(id);

    result.fold(
      (error) => emit(ProductDetailError(error)),
      (product) => emit(ProductDetailLoaded(product)),
    );
  }

  Future<void> searchProducts(String query) async {
    if (query.isEmpty) {
      emit(ProductsInitial());
      return;
    }

    emit(ProductsSearching());

    final result = await searchProductsUsecase(query);

    result.fold(
      (error) => emit(ProductsError(error)),
      (products) => emit(ProductsSearchResult(
        products: products,
        query: query,
      )),
    );
  }

  void resetProducts() {
    _currentPage = 0;
    _allProducts = [];
    emit(ProductsInitial());
  }
}
