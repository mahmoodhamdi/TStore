import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:t_store/core/cubits/navigation_menu_cubit/navigation_menu_cubit.dart';
import 'package:t_store/features/shop/data/data_sources/shop_remote_data_source.dart';
import 'package:t_store/features/shop/data/repository_impl/shop_repository_impl.dart';
import 'package:t_store/features/shop/domain/usecases/get_product_by_id_usecase.dart';
import 'package:t_store/features/shop/domain/usecases/get_products_by_category_usecase.dart';
import 'package:t_store/features/shop/domain/usecases/get_products_by_search_usecase.dart';
import 'package:t_store/features/shop/domain/usecases/get_products_list_usecase.dart';
import 'package:t_store/features/shop/domain/usecases/get_sorted_products_usecase.dart';
import 'package:t_store/features/shop/presentation/controller/shop_cubit.dart';

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
  getIt.registerSingleton<GetProductsListUsecase>(
      GetProductsListUsecase(shopRepository: getIt.get<ShopRepositoryImpl>()));

  getIt.registerSingleton<GetProductsBySearchUsecase>(
      GetProductsBySearchUsecase(
          shopRepository: getIt.get<ShopRepositoryImpl>()));
  getIt.registerSingleton<GetProductsByCategoryUsecase>(
      GetProductsByCategoryUsecase(
          shopRepository: getIt.get<ShopRepositoryImpl>()));

  getIt.registerSingleton<GetProductByIdUsecase>(
      GetProductByIdUsecase(shopRepository: getIt.get<ShopRepositoryImpl>()));
  getIt.registerSingleton<GetSortedProductsUsecase>(GetSortedProductsUsecase(
      shopRepository: getIt.get<ShopRepositoryImpl>()));

// register controllers
 // NavigationMenuCubit
 getIt.registerSingleton<NavigationMenuCubit>(NavigationMenuCubit());
  getIt.registerSingleton<ShopCubit>(ShopCubit(
    getProductsListUsecase: getIt.get<GetProductsListUsecase>(),
    getProductsBySearchUsecase: getIt.get<GetProductsBySearchUsecase>(),
    getProductsByCategoryUsecase: getIt.get<GetProductsByCategoryUsecase>(),
    getProductByIdUsecase: getIt.get<GetProductByIdUsecase>(),
    getSortedProductsUsecase: getIt.get<GetSortedProductsUsecase>(),
  ));
}
