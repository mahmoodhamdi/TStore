import 'package:flutter/material.dart';
import 'package:t_store/core/common/models/app_bar_model.dart';
import 'package:t_store/core/common/models/rounded_image_model.dart';
import 'package:t_store/core/common/models/section_heading_model.dart';
import 'package:t_store/core/common/widgets/app_bar.dart';
import 'package:t_store/core/common/widgets/horizontal_product_card.dart';
import 'package:t_store/core/common/widgets/rounded_image.dart';
import 'package:t_store/core/common/widgets/section_heading.dart';
import 'package:t_store/core/utils/constants/image_strings.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/helpers/helper_functions.dart';

class SubCategoryView extends StatelessWidget {
  const SubCategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: CustomAppBar(
        appBarModel:
            AppBarModel(hasArrowBack: true, title: const Text("Sports Shirts")),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              RoundedImage(
                roundedImageModel: RoundedImageModel(
                  image: TImages.promoBanner2,
                  applyImageRadius: true,
                  width: double.infinity,
                ),
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              Column(
                children: [
                  SectionHeading(
                      sectionHeadingModel: SectionHeadingModel(
                    title: "Sports Shirts",
                  )),
                  const SizedBox(
                    height: TSizes.spaceBtwItems / 2,
                  ),
                  SizedBox(
                    height: 128,
                    child: ListView.separated(
                        itemCount: 5,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) =>
                            const HorizontalProductCard(),
                        separatorBuilder: (context, index) => const SizedBox(
                              width: TSizes.spaceBtwItems,
                            )),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
