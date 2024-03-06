import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';
import 'package:t_store/core/common/models/section_heading_model.dart';
import 'package:t_store/core/common/widgets/section_heading.dart';
import 'package:t_store/core/utils/constants/sizes.dart';

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
        const ReadMoreText(
          //long product description
          "This Is The Description Of The Product This Is The Description Of The Product This Is The Description Of The Product This Is The Description Of The Product For Blue Nike Sleeve Vest. There Are More Things Can Be Added",
          trimLines: 2,
          trimMode: TrimMode.Line,
          trimCollapsedText: "Show More",
          trimExpandedText: "Show Less",
          moreStyle: TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
          lessStyle: TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
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
                onPressed: () {},
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
