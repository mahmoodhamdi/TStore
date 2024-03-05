import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';
import 'package:t_store/core/common/models/circular_icon_model.dart';
import 'package:t_store/core/common/models/section_heading_model.dart';
import 'package:t_store/core/common/widgets/circular_icon.dart';
import 'package:t_store/core/common/widgets/section_heading.dart';
import 'package:t_store/core/utils/constants/colors.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/helpers/helper_functions.dart';
import 'package:t_store/features/shop/presentation/widgets/product_attributes.dart';
import 'package:t_store/features/shop/presentation/widgets/product_image_slider.dart';
import 'package:t_store/features/shop/presentation/widgets/product_metadata.dart';
import 'package:t_store/features/shop/presentation/widgets/rating_and_share.dart';

class BottomAddToCart extends StatelessWidget {
  const BottomAddToCart({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Container(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      decoration: BoxDecoration(
        color: dark ? TColors.darkGrey : TColors.light,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(TSizes.cardRadiusLg),
          topRight: Radius.circular(TSizes.cardRadiusLg),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircularIcon(
                circularIconModel: CircularIconModel(
                    icon: Iconsax.minus,
                    height: 40,
                    width: 40,
                    color: TColors.white,
                    backgroundColor: TColors.darkerGrey,
                    onPressed: () {}),
              ),
              const SizedBox(
                width: TSizes.spaceBtwItems,
              ),
              Text(
                "2",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(
                width: TSizes.spaceBtwItems,
              ),
              CircularIcon(
                circularIconModel: CircularIconModel(
                    icon: Iconsax.add,
                    height: 40,
                    width: 40,
                    color: TColors.white,
                    backgroundColor: TColors.black,
                    onPressed: () {}),
              ),
              const SizedBox(
                width: TSizes.spaceBtwItems,
              ),
            ],
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(TSizes.md),
                backgroundColor: TColors.black,
                side: const BorderSide(color: TColors.black),
              ),
              onPressed: () {},
              child: const Text("Add To Cart")),
        ],
      ),
    );
  }
}

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
        bottomNavigationBar: const BottomAddToCart(),
        body: SingleChildScrollView(
            child: Column(
          children: [
            const ProductImageSlider(),
            Padding(
              padding: const EdgeInsets.fromLTRB(TSizes.defaultSpace, 0,
                  TSizes.defaultSpace, TSizes.defaultSpace),
              child: Column(
                children: [
                  const RatingAndShare(),
                  const ProductMetadata(),
                  const ProductAttributes(),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {}, child: const Text("Checkout")),
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
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
                    moreStyle:
                        TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
                    lessStyle:
                        TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems / 2),
                  const Divider(),
                  const SizedBox(height: TSizes.spaceBtwItems),
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
                  const SizedBox(height: TSizes.spaceBtwSections),
                ],
              ),
            )
          ],
        )));
  }
}
