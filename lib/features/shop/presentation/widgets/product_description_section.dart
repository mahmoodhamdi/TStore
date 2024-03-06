import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/core/common/models/section_heading_model.dart';
import 'package:t_store/core/common/widgets/read_more.dart';
import 'package:t_store/core/common/widgets/section_heading.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/helpers/helper_functions.dart';
import 'package:t_store/features/shop/presentation/views/product_reviews_view.dart';

class ProductDescriptionAndReviewsSection extends StatelessWidget {
  const ProductDescriptionAndReviewsSection({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionHeading(
            sectionHeadingModel: SectionHeadingModel(
                title: "Description", showActionButton: false)),
        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        const ReadMore(
          text:
              "mahmoud hamdy fathy elashwah flutter developer at myself and i major to make backword by etoo in pes 6 ",
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 2),
        const Divider(),
        const SizedBox(height: TSizes.spaceBtwItems / 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SectionHeading(
                sectionHeadingModel: SectionHeadingModel(
              title: "Reviews(199)",
              showActionButton: false,
            )),
            TextButton(
                onPressed: () {
                  THelperFunctions.navigateToScreen(
                      context, const ProductReviewsView());
                },
                child: const Icon(
                  Iconsax.arrow_right_3,
                  size: 18,
                ))
          ],
        ),
      ],
    );
  }
}
