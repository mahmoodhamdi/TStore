import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/core/utils/constants/text_strings.dart';
import 'package:t_store/core/utils/theme/theme.dart';
import 'package:t_store/features/auth/presentation/cubit/on_boarding_cubit.dart';
import 'package:t_store/features/auth/presentation/views/on_boarding/on_boarding_view.dart';
import 'package:t_store/features/shop/data/data_sources/shop_remote_data_source.dart';
import 'package:t_store/features/shop/data/repository_impl/shop_repository_impl.dart';
import 'package:t_store/features/shop/domain/usecases/get_product_by_id_usecase.dart';

void main() async {
  // var products = await GetProductsListUsecase(
  //         shopRepository: ShopRepositoryImpl(
  //             remoteDataSource: ShopRemoteDataSourceImpl(dio: Dio())))
  //     .call();
  // products.fold((l) => print(l.message), (r) => print(r));
  // var categories = await GetCategoriesListUsecase(
  //   shopRepository: ShopRepositoryImpl(
  //       remoteDataSource: ShopRemoteDataSourceImpl(dio: Dio())),
  // ).call();
  // categories.fold((l) => print(l.message), (r) => print(r));
  // var productsByCategory = await GetProductsByCategoryUsecase(
  //         shopRepository: ShopRepositoryImpl(
  //             remoteDataSource: ShopRemoteDataSourceImpl(dio: Dio())))
  //     .call(categoryId: 5);
  // productsByCategory.fold((l) => print(l.message), (r) => print(r.length));
  // var productsByCategoryAndSearch = await GetProductsByCategoryAndSearchUsecase(
  //   shopRepository:   ShopRepositoryImpl(
  //       remoteDataSource: ShopRemoteDataSourceImpl(dio: Dio())),
  //   ).call(categoryId: 1, search: "");
  // productsByCategoryAndSearch.fold((l) => print(l.message), (r) => print(r.length));

  // var productsBySearch = await GetProductsBySearchUsecase(
  //   shopRepository: ShopRepositoryImpl(
  //       remoteDataSource: ShopRemoteDataSourceImpl(dio: Dio())),
  // ).call( search: "");
  // productsBySearch.fold(
  //     (l) => print(l.message), (r) => print(r.length));
  // var productsByFilters = await GetProductsByFiltersUsecase(
  //   shopRepository: ShopRepositoryImpl(
  //       remoteDataSource: ShopRemoteDataSourceImpl(dio: Dio())),
  // ).call();
  // productsByFilters.fold(
  //   (l) => print(l.message),
  //   (r) => print(r.length),
  // );
  // var productsByPriceRange = await GetProductsByPriceRangeUsecase(
  //   shopRepository: ShopRepositoryImpl(
  //       remoteDataSource: ShopRemoteDataSourceImpl(dio: Dio())),
  // ).call(
  // );
  // productsByPriceRange.fold(
  //   (l) => print(l.message),
  //   (r) => print(r.length),
  // );
  // var category = await GetCategoryByIdUsecase(
  //   shopRepository: ShopRepositoryImpl(
  //       remoteDataSource: ShopRemoteDataSourceImpl(dio: Dio())),
  // ).call(categoryId: 1);
  // category.fold((l) => print(l.message), (r) => print(r));
  // var productById = await GetProductByIdUsecase(
  //   shopRepository: ShopRepositoryImpl(
  //       remoteDataSource: ShopRemoteDataSourceImpl(dio: Dio())),
  // ).call(productId: 1);
  // productById.fold((l) => print(l.message), (r) => print(r));
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: TTexts.appName,
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => OnBoardingCubit(),
        child: const OnBoardingView(),
      ),
    );
  }
}
