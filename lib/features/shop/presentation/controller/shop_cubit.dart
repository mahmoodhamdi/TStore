import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/core/utils/exceptions/exceptions.dart';
import 'package:t_store/features/shop/domain/entities/product_entity.dart';
import 'package:t_store/features/shop/domain/usecases/get_product_by_id_usecase.dart';
import 'package:t_store/features/shop/domain/usecases/get_products_by_category_usecase.dart';
import 'package:t_store/features/shop/domain/usecases/get_products_by_search_usecase.dart';
import 'package:t_store/features/shop/domain/usecases/get_products_list_usecase.dart';
import 'package:t_store/features/shop/domain/usecases/get_sorted_products_usecase.dart';

part 'shop_state.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit(
      {required this.getProductsListUsecase,
      required this.getSortedProductsUsecase,
      required this.getProductByIdUsecase,
      required this.getProductsByCategoryUsecase,
      required this.getProductsBySearchUsecase})
      : super(ShopInitial());
  final GetProductsListUsecase getProductsListUsecase;
  final GetSortedProductsUsecase getSortedProductsUsecase;
  final GetProductByIdUsecase getProductByIdUsecase;
  final GetProductsByCategoryUsecase getProductsByCategoryUsecase;
  final GetProductsBySearchUsecase getProductsBySearchUsecase;
  String sortBy = "title";
  List<String> sortByList = const [
    "title",
    "price",
    "rating",
    "stock",
    "date",
  ];

  void getProductsList() async {
    emit(ShopLoading());

    final products = await getProductsListUsecase.call();
    products.fold((error) => emit(ShopError(error: error)),
        (productsList) => emit(ShopProductsLoaded(productsList: productsList)));
  }

  void getSortedProducts(
      {required String sortBy, required String sortType}) async {
    emit(ShopLoading());
    final products =
        await getSortedProductsUsecase.call(sortBy: sortBy, sortType: sortType);
    products.fold(
        (error) => emit(ShopError(error: error)),
        (productsList) =>
            emit(ShopSortedProductsLoaded(productsList: productsList)));
  }

  void getProductById({required int productId}) async {
    emit(ShopLoading());
    final product = await getProductByIdUsecase.call(productId: productId);
    product.fold((error) => emit(ShopError(error: error)),
        (product) => emit(ShopProductLoaded(product: product)));
  }

  void getProductsByCategory({required String categoryName}) async {
    emit(ShopLoading());
    final products =
        await getProductsByCategoryUsecase.call(categoryName: categoryName);
    products.fold(
        (error) => emit(ShopError(error: error)),
        (productsList) =>
            emit(ShopCategoryProductsLoaded(productsList: productsList)));
  }

  void getProductsBySearch({String? search}) async {
    emit(ShopLoading());
    final products = await getProductsBySearchUsecase.call(search: search);
    products.fold(
        (error) => emit(ShopError(error: error)),
        (productsList) =>
            emit(ShopSearchProductsLoaded(productsList: productsList)));
  }
}
