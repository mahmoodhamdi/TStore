import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/core/common/view_models/grid_layout_view_model.dart';
import 'package:t_store/core/common/view_models/section_heading_view_model.dart';
import 'package:t_store/core/common/widgets/section_heading.dart';
import 'package:t_store/core/common/widgets/vertical_product_card.dart';
import 'package:t_store/core/cubits/banner_carousel_slider_cubit_cubit/banner_carousel_slider_cubit.dart';
import 'package:t_store/core/utils/constants/colors.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/helpers/helper_functions.dart';
import 'package:t_store/core/utils/service_locator/service_locator.dart';
import 'package:t_store/features/auth/presentation/widgets/grid_layout.dart';
import 'package:t_store/features/shop/presentation/controller/shop_cubit.dart';
import 'package:t_store/features/shop/presentation/views/all_products_view.dart';
import 'package:t_store/features/shop/presentation/widgets/home_header_section.dart';
import 'package:t_store/features/shop/presentation/widgets/promo_banner_carousel_slider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const HomeHeaderSection(),
              const SizedBox(height: TSizes.spaceBtwSections),
              BlocProvider(
                create: (context) => BannerCarouselSliderCubit(),
                child: const PromoBannerCarouselSlider(),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              SectionHeading(
                sectionHeadingModel: SectionHeadingModel(
                  title: "Top Rated Products",
                  showActionButton: true,
                  textColor: TColors.primary,
                  actionButtonOnPressed: () {
                    THelperFunctions.navigateToScreen(
                      context,
                      BlocProvider(
                          create: (context) => getIt<ShopCubit>()..getSortedProducts(sortBy: 'rating', sortType: "desc"),
                          child: const AllProductsView()),
                    );
                  },
                  actionButtonTitle: "View All",
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              BlocBuilder<ShopCubit, ShopState>(
                builder: (context, state) {
                  if (state is ShopError) {
                    return Text(state.error.message);
                  }
                  if (state is ShopSortedProductsLoaded) {
                    return GridLayout(
                        gridLayoutModel: GridLayoutModel(
                      itemCount: state.productsList.length,
                      itemBuilder: (context, index) {
                        return VerticalProductCard(
                            product: state.productsList[index]);
                      },
                      mainAxisExtent: 288,
                    ));
                  }
                  return const CircularProgressIndicator();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
