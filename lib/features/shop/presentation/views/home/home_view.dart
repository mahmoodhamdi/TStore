import 'package:flutter/material.dart';
import 'package:t_store/core/models/grid_layout_model.dart';
import 'package:t_store/core/models/section_heading_model.dart';
import 'package:t_store/core/utils/constants/colors.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/widgets/section_heading.dart';
import 'package:t_store/core/widgets/vertical_product_card.dart';
import 'package:t_store/features/auth/presentation/widgets/grid_layout.dart';
import 'package:t_store/features/shop/presentation/widgets/home_header_section.dart';
import 'package:t_store/features/shop/presentation/widgets/promo_banner_carousel_slider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const HomeHeaderSection(),
            const SizedBox(height: TSizes.spaceBtwSections),
            const PromoBannerCarouselSlider(),
            const SizedBox(height: TSizes.spaceBtwSections),
            SectionHeading(
              sectionHeadingModel: SectionHeadingModel(
                title: "Popular Pro",
                showActionButton: true,
                textColor: TColors.primary,
                actionButtonTitle: "View All",
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            GridLayout(
                gridLayoutModel: GridLayoutModel(
              itemCount: 10,
              itemBuilder: (context, index) {
                return const VerticalProductCard();
              },
              mainAxisExtent: 288,
            )),
          ],
        ),
      ),
    );
  }
}
