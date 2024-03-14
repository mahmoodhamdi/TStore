import 'package:flutter/material.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/features/shop/presentation/widgets/home_header_section.dart';
import 'package:t_store/features/shop/presentation/widgets/popular_products.dart';
import 'package:t_store/features/shop/presentation/widgets/promo_banner_carousel_slider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            HomeHeaderSection(),
            SizedBox(height: TSizes.spaceBtwSections),
            PromoBannerCarouselSlider(),
            SizedBox(height: TSizes.spaceBtwSections),
            PopularProducts(),
          ],
        ),
      ),
    );
  }
}
