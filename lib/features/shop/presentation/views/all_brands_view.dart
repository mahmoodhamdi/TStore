import 'package:flutter/material.dart';
import 'package:t_store/core/common/models/app_bar_model.dart';
import 'package:t_store/core/common/models/brand_card_model.dart';
import 'package:t_store/core/common/models/grid_layout_model.dart';
import 'package:t_store/core/common/models/section_heading_model.dart';
import 'package:t_store/core/common/widgets/app_bar.dart';
import 'package:t_store/core/common/widgets/brand_card.dart';
import 'package:t_store/core/common/widgets/section_heading.dart';
import 'package:t_store/core/utils/constants/image_strings.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/constants/text_strings.dart';
import 'package:t_store/core/utils/helpers/helper_functions.dart';
import 'package:t_store/features/auth/presentation/widgets/grid_layout.dart';
import 'package:t_store/features/shop/presentation/views/brand_products_view.dart';

class AllBrandsView extends StatelessWidget {
  const AllBrandsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBarModel:
            AppBarModel(title: const Text("All Brands"), hasArrowBack: true),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            SectionHeading(
              sectionHeadingModel: SectionHeadingModel(
                title: "All Brands",
                showActionButton: false,
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            GridLayout(
                gridLayoutModel: GridLayoutModel(
              itemCount: 10,
              mainAxisExtent: 80,
              itemBuilder: (context, index) {
                return BrandCard(
                  brandCardModel: BrandCardModel(
                    onTap: () {
                      THelperFunctions.navigateToScreen(
                        context,
                        const BrandProductsView(),
                      );
                    },
                    showBorder: true,
                    productCount: TTexts.brandTitles.length,
                    brandName: TTexts.brandTitles[index],
                    image: TImages.brandIcons[index],
                  ),
                );
              },
            )),
          ],
        ),
      )),
    );
  }
}
