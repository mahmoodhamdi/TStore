import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:t_store/core/common/view_models/grid_layout_view_model.dart';
import 'package:t_store/core/common/view_models/section_heading_view_model.dart';
import 'package:t_store/core/common/widgets/section_heading.dart';
import 'package:t_store/core/common/widgets/vertical_product_card.dart';
import 'package:t_store/core/utils/constants/colors.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/helpers/helper_functions.dart';
import 'package:t_store/features/auth/presentation/widgets/grid_layout.dart';
import 'package:t_store/features/shop/presentation/cubit/products_cubit.dart';
import 'package:t_store/features/shop/presentation/cubit/products_state.dart';
import 'package:t_store/features/shop/presentation/views/all_products_view.dart';
import 'package:t_store/features/shop/presentation/widgets/home_header_section.dart';
import 'package:t_store/features/shop/presentation/widgets/promo_banner_carousel_slider.dart';

class HomeViewShimmer extends StatelessWidget {
  const HomeViewShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Shimmer.fromColors(
      baseColor: dark ? Colors.grey[850]! : Colors.grey[300]!,
      highlightColor: dark ? Colors.grey[700]! : Colors.grey[100]!,
      child: Column(
        children: [
          // Header Section Shimmer
          Container(
            height: 60,
            padding: const EdgeInsets.all(TSizes.md),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwSections),

          // Banner Carousel Shimmer
          Container(
            height: 180,
            margin: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwSections),

          // Section Heading Shimmer
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 120,
                  height: 20,
                  color: Colors.white,
                ),
                Container(
                  width: 80,
                  height: 20,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwItems),

          // Grid Layout Shimmer
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding:
                const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: TSizes.gridViewSpacing,
              crossAxisSpacing: TSizes.gridViewSpacing,
              mainAxisExtent: 288,
            ),
            itemCount: 4,
            itemBuilder: (_, _) => Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(TSizes.productImageRadius),
              ),
              child: Column(
                children: [
                  // Product Image Shimmer
                  Expanded(
                    flex: 6,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(TSizes.productImageRadius),
                      ),
                    ),
                  ),
                  // Product Details Shimmer
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(TSizes.sm),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 20,
                            color: Colors.white,
                          ),
                          const SizedBox(height: TSizes.spaceBtwItems / 2),
                          Container(
                            width: 100,
                            height: 16,
                            color: Colors.white,
                          ),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 60,
                                height: 20,
                                color: Colors.white,
                              ),
                              Container(
                                width: 40,
                                height: 40,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    // Load featured products on init
    context.read<ProductsCubit>().getProducts(
          isFeatured: true,
          sortBy: 'rating',
          ascending: false,
          refresh: true,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const HomeHeaderSection(),
              const SizedBox(height: TSizes.spaceBtwSections),
              const PromoBannerCarouselSlider(),
              const SizedBox(height: TSizes.spaceBtwSections),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SectionHeading(
                  sectionHeadingModel: SectionHeadingModel(
                    title: "Top Rated Products",
                    showActionButton: true,
                    textColor: TColors.primary,
                    actionButtonOnPressed: () {
                      THelperFunctions.navigateToScreen(
                        context,
                        const AllProductsView(),
                      );
                    },
                    actionButtonTitle: "View All",
                  ),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              BlocBuilder<ProductsCubit, ProductsState>(
                builder: (context, state) {
                  if (state is ProductsError) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(TSizes.defaultSpace),
                        child: Column(
                          children: [
                            Text(
                              state.message,
                              style: Theme.of(context).textTheme.bodyMedium,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: TSizes.spaceBtwItems),
                            ElevatedButton(
                              onPressed: () {
                                context.read<ProductsCubit>().getProducts(
                                      isFeatured: true,
                                      sortBy: 'rating',
                                      ascending: false,
                                      refresh: true,
                                    );
                              },
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  if (state is ProductsLoaded) {
                    if (state.products.isEmpty) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(TSizes.defaultSpace),
                          child: Text('No products found'),
                        ),
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: GridLayout(
                        gridLayoutModel: GridLayoutModel(
                          itemCount: state.products.length > 4
                              ? 4
                              : state.products.length,
                          itemBuilder: (context, index) {
                            return VerticalProductCard(
                              product: state.products[index],
                            );
                          },
                          mainAxisExtent: 288,
                        ),
                      ),
                    );
                  }
                  return const HomeViewShimmer();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
