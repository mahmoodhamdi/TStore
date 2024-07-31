import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:t_store/features/shop/data/data_sources/shop_remote_data_source.dart';
import 'package:t_store/features/shop/data/repository_impl/shop_repository_impl.dart';
import 'package:t_store/features/shop/domain/usecases/get_categories_list_usecase.dart';
import 'package:t_store/features/shop/domain/usecases/get_category_by_id_usecase.dart';
import 'package:t_store/features/shop/domain/usecases/get_product_by_id_usecase.dart';
import 'package:t_store/features/shop/domain/usecases/get_products_by_category_and_search_usecase.dart';
import 'package:t_store/features/shop/domain/usecases/get_products_by_category_usecase.dart';
import 'package:t_store/features/shop/domain/usecases/get_products_by_filters_usecase.dart';
import 'package:t_store/features/shop/domain/usecases/get_products_by_price_range_usecase.dart';
import 'package:t_store/features/shop/domain/usecases/get_products_by_search_usecase.dart';
import 'package:t_store/features/shop/domain/usecases/get_products_list_usecase.dart';

final getIt = GetIt.instance;

setupServiceLocator() {
  getIt.registerSingleton<Dio>(Dio());
// register data sources
  getIt.registerSingleton<ShopRemoteDataSourceImpl>(ShopRemoteDataSourceImpl(
    dio: getIt.get<Dio>(),
  ));
// register repositories
  getIt.registerSingleton<ShopRepositoryImpl>(ShopRepositoryImpl(
    remoteDataSource: getIt.get<ShopRemoteDataSourceImpl>(),
  ));
// register use cases
  getIt.registerSingleton(GetCategoriesListUsecase(
      shopRepository: getIt.get<ShopRepositoryImpl>()));
  getIt.registerSingleton<GetCategoryByIdUsecase>(
      GetCategoryByIdUsecase(shopRepository: getIt.get<ShopRepositoryImpl>()));
  getIt.registerSingleton<GetProductsListUsecase>(
      GetProductsListUsecase(shopRepository: getIt.get<ShopRepositoryImpl>()));

  getIt.registerSingleton<GetProductsBySearchUsecase>(
      GetProductsBySearchUsecase(
          shopRepository: getIt.get<ShopRepositoryImpl>()));
  getIt.registerSingleton<GetProductsByCategoryUsecase>(
      GetProductsByCategoryUsecase(
          shopRepository: getIt.get<ShopRepositoryImpl>()));
  getIt.registerSingleton<GetProductsByCategoryAndSearchUsecase>(
      GetProductsByCategoryAndSearchUsecase(
          shopRepository: getIt.get<ShopRepositoryImpl>()));
  getIt.registerSingleton<GetProductsByFiltersUsecase>(
      GetProductsByFiltersUsecase(
          shopRepository: getIt.get<ShopRepositoryImpl>()));
  getIt.registerSingleton<GetProductsByPriceRangeUsecase>(
    GetProductsByPriceRangeUsecase(
        shopRepository: getIt.get<ShopRepositoryImpl>()),
  );

  getIt.registerSingleton<GetProductByIdUsecase>(
      GetProductByIdUsecase(shopRepository: getIt.get<ShopRepositoryImpl>()));
}
