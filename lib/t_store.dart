import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/core/cubits/banner_carousel_slider_cubit_cubit/banner_carousel_slider_cubit.dart';
import 'package:t_store/core/dependency_injection/service_locator.dart';
import 'package:t_store/core/utils/constants/text_strings.dart';
import 'package:t_store/core/utils/theme/theme.dart';
import 'package:t_store/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:t_store/features/auth/presentation/logic/on_boarding/on_boarding_cubit.dart';
import 'package:t_store/features/auth/presentation/views/on_boarding/on_boarding_view.dart';
import 'package:t_store/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:t_store/features/shop/presentation/cubit/banners_cubit.dart';
import 'package:t_store/features/shop/presentation/cubit/brands_cubit.dart';
import 'package:t_store/features/shop/presentation/cubit/categories_cubit.dart';
import 'package:t_store/features/shop/presentation/cubit/products_cubit.dart';
import 'package:t_store/features/wishlist/presentation/cubit/wishlist_cubit.dart';

class TStore extends StatelessWidget {
  const TStore({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Auth
        BlocProvider<AuthCubit>(create: (_) => sl<AuthCubit>()),

        // Shop
        BlocProvider<ProductsCubit>(create: (_) => sl<ProductsCubit>()),
        BlocProvider<CategoriesCubit>(create: (_) => sl<CategoriesCubit>()),
        BlocProvider<BrandsCubit>(create: (_) => sl<BrandsCubit>()),
        BlocProvider<BannersCubit>(create: (_) => sl<BannersCubit>()),

        // Cart & Wishlist
        BlocProvider<CartCubit>(create: (_) => sl<CartCubit>()),
        BlocProvider<WishlistCubit>(create: (_) => sl<WishlistCubit>()),

        // OnBoarding
        BlocProvider<OnBoardingCubit>(create: (_) => OnBoardingCubit()),

        // UI State
        BlocProvider<BannerCarouselSliderCubit>(
            create: (_) => BannerCarouselSliderCubit()),
      ],
      child: MaterialApp(
        title: TTexts.appName,
        themeMode: ThemeMode.system,
        theme: TAppTheme.lightTheme,
        darkTheme: TAppTheme.darkTheme,
        debugShowCheckedModeBanner: false,
        home: const OnBoardingView(),
      ),
    );
  }
}
