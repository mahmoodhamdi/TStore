import 'package:flutter/material.dart';
import 'package:t_store/core/common/view_models/category_tab_view_model.dart';
import 'package:t_store/core/common/view_models/grid_layout_view_model.dart';
import 'package:t_store/core/common/view_models/section_heading_view_model.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/common/widgets/brand_showcase.dart';
import 'package:t_store/core/common/widgets/section_heading.dart';
import 'package:t_store/core/common/widgets/vertical_product_card.dart';
import 'package:t_store/features/auth/presentation/widgets/grid_layout.dart';

class CategoryTab extends StatelessWidget {
  const CategoryTab({
    super.key,
    required this.categoryTabModel,
  });
  final CategoryTabModel categoryTabModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: SingleChildScrollView(
        child: Column(
          children: [
            BrandShowcase(
              categoryTabModel.brandShowcaseModel,
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            SectionHeading(
                sectionHeadingModel: SectionHeadingModel(
              title: "You Might Like",
              showActionButton: true,
              actionButtonOnPressed: () {},
            )),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            GridLayout(
              gridLayoutModel: GridLayoutModel(
                  itemCount: categoryTabModel.products.length - 50,
                  itemBuilder: (context, index) {
                    return const VerticalProductCard();
                  },
                  mainAxisExtent: 280),
            ),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            )
          ],
        ),
      ),
    );
  }
}
