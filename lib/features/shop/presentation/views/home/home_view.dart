import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/core/models/search_container_model.dart';
import 'package:t_store/core/models/section_heading_model.dart';
import 'package:t_store/core/utils/constants/colors.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/constants/text_strings.dart';
import 'package:t_store/core/widgets/primary_header_container.dart';
import 'package:t_store/core/widgets/search_container.dart';
import 'package:t_store/core/widgets/section_heading.dart';
import 'package:t_store/features/shop/presentation/widgets/home_app_bar.dart';
import 'package:t_store/features/shop/presentation/widgets/home_categories.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final SectionHeadingModel sectionHeadingModel = SectionHeadingModel(
      showActionButton: false,
      title: TTexts.popularCategories,
      textColor: TColors.white,
    );
    final SearchContainerModel searchContainerModel = SearchContainerModel(
      icon: Iconsax.search_normal,
      title: TTexts.searchContainer,
      showBackground: true,
      showBorder: true,
    );
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            PrimaryHeaderContainer(
              child: Column(
                children: [
                  const HomeAppBar(),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  SearchContainer(searchContainerModel: searchContainerModel),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: TSizes.defaultSpace),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SectionHeading(
                            sectionHeadingModel: sectionHeadingModel,
                          ),
                          const SizedBox(height: TSizes.spaceBtwSections),
                          const HomeCategories(),
                          const SizedBox(height: TSizes.spaceBtwSections),
                        ],
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
