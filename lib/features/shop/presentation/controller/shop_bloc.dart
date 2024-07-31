import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:t_store/core/utils/exceptions/exceptions.dart';
import 'package:t_store/features/shop/domain/entities/category_entity.dart';
import 'package:t_store/features/shop/domain/entities/product_entity.dart';
import 'package:t_store/features/shop/domain/usecases/get_categories_list_usecase.dart';
import 'package:t_store/features/shop/domain/usecases/get_category_by_id_usecase.dart';
import 'package:t_store/features/shop/domain/usecases/get_product_by_id_usecase.dart';
import 'package:t_store/features/shop/domain/usecases/get_products_by_category_and_search_usecase.dart';
import 'package:t_store/features/shop/domain/usecases/get_products_by_category_usecase.dart';
import 'package:t_store/features/shop/domain/usecases/get_products_by_filters_usecase.dart';
import 'package:t_store/features/shop/domain/usecases/get_products_by_price_range_usecase.dart';
import 'package:t_store/features/shop/domain/usecases/get_products_by_search_usecase.dart';
import 'package:t_store/features/shop/domain/usecases/get_products_list_usecase.dart';

part 'shop_event.dart';
part 'shop_state.dart';

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  final GetCategoriesListUsecase getCategoriesListUsecase;
  final GetCategoryByIdUsecase getCategoryByIdUsecase;
  final GetProductByIdUsecase getProductByIdUsecase;
  final GetProductsByCategoryAndSearchUsecase
      getProductsByCategoryAndSearchUsecase;
  final GetProductsByCategoryUsecase getProductsByCategoryUsecase;
  final GetProductsByFiltersUsecase getProductsByFiltersUsecase;
  final GetProductsByPriceRangeUsecase getProductsByPriceRangeUsecase;
  final GetProductsBySearchUsecase getProductsBySearchUsecase;
  final GetProductsListUsecase getProductsListUsecase;

  ShopBloc({
    required this.getCategoriesListUsecase,
    required this.getCategoryByIdUsecase,
    required this.getProductByIdUsecase,
    required this.getProductsByCategoryAndSearchUsecase,
    required this.getProductsByCategoryUsecase,
    required this.getProductsByFiltersUsecase,
    required this.getProductsByPriceRangeUsecase,
    required this.getProductsBySearchUsecase,
    required this.getProductsListUsecase,
  }) : super(ShopInitial()) {
    on<GetCategoriesListEvent>(_onGetCategoriesListEvent);
    on<GetCategoryByIdEvent>(_onGetCategoryByIdEvent);
    on<GetProductsListEvent>(_onGetProductsListEvent);
    on<GetProductByIdEvent>(_onGetProductByIdEvent);
    on<GetProductsByCategoryEvent>(_onGetProductsByCategoryEvent);
    on<GetProductsByCategoryAndSearchEvent>(
        _onGetProductsByCategoryAndSearchEvent);
    on<GetProductsBySearchEvent>(_onGetProductsBySearchEvent);
    on<GetProductsByFiltersEvent>(_onGetProductsByFiltersEvent);
    on<GetProductsByPriceRangeEvent>(_onGetProductsByPriceRangeEvent);
  }

  Future<void> _onGetCategoriesListEvent(
      GetCategoriesListEvent event, Emitter<ShopState> emit) async {
    emit(ShopLoadingState());
    final result = await getCategoriesListUsecase();
    result.fold(
      (failure) => emit(ShopErrorState(failure)),
      (categories) => emit(ShopCategoriesLoadedState(categories)),
    );
  }

  Future<void> _onGetCategoryByIdEvent(
      GetCategoryByIdEvent event, Emitter<ShopState> emit) async {
    emit(ShopLoadingState());
    final result = await getCategoryByIdUsecase(categoryId: event.id);
    result.fold(
      (failure) => emit(ShopErrorState(failure)),
      (category) => emit(ShopCategoryLoadedState(category)),
    );
  }

  Future<void> _onGetProductsListEvent(
      GetProductsListEvent event, Emitter<ShopState> emit) async {
    emit(ShopLoadingState());
    final result = await getProductsListUsecase();
    result.fold(
      (failure) => emit(ShopErrorState(failure)),
      (products) => emit(ShopProductsLoadedState(products)),
    );
  }

  Future<void> _onGetProductByIdEvent(
      GetProductByIdEvent event, Emitter<ShopState> emit) async {
    emit(ShopLoadingState());
    final result = await getProductByIdUsecase(productId: event.id);
    result.fold(
      (failure) => emit(ShopErrorState(failure)),
      (product) => emit(ShopProductLoadedState(product)),
    );
  }

  Future<void> _onGetProductsByCategoryEvent(
      GetProductsByCategoryEvent event, Emitter<ShopState> emit) async {
    emit(ShopLoadingState());
    final result = await getProductsByCategoryUsecase(categoryId:  event.id);
    result.fold(
      (failure) => emit(ShopErrorState(failure)),
      (products) => emit(ShopProductsLoadedState(products)),
    );
  }

  Future<void> _onGetProductsByCategoryAndSearchEvent(
      GetProductsByCategoryAndSearchEvent event,
      Emitter<ShopState> emit) async {
    emit(ShopLoadingState());
    final result = await getProductsByCategoryAndSearchUsecase(
      categoryId: event.id,
      search: event.search,
    );
    result.fold(
      (failure) => emit(ShopErrorState(failure)),
      (products) => emit(ShopProductsLoadedState(products)),
    );
  }

  Future<void> _onGetProductsBySearchEvent(
      GetProductsBySearchEvent event, Emitter<ShopState> emit) async {
    emit(ShopLoadingState());
    final result = await getProductsBySearchUsecase(search:  event.search);
    result.fold(
      (failure) => emit(ShopErrorState(failure)),
      (products) => emit(ShopProductsLoadedState(products)),
    );
  }

  Future<void> _onGetProductsByFiltersEvent(
      GetProductsByFiltersEvent event, Emitter<ShopState> emit) async {
    emit(ShopLoadingState());
    final result = await getProductsByFiltersUsecase(
      categoryId: event.categoryId,
      search: event.search,
      maxPrice: event.maxPrice,
      minPrice: event.minPrice,
    );
    result.fold(
      (failure) => emit(ShopErrorState(failure)),
      (products) => emit(ShopProductsLoadedState(products)),
    );
  }

  Future<void> _onGetProductsByPriceRangeEvent(
      GetProductsByPriceRangeEvent event, Emitter<ShopState> emit) async {
    emit(ShopLoadingState());
    final result = await getProductsByPriceRangeUsecase(
      maxPrice: event.maxPrice,
      minPrice: event.minPrice,
    );
    result.fold(
      (failure) => emit(ShopErrorState(failure)),
      (products) => emit(ShopProductsLoadedState(products)),
    );
  }
}
