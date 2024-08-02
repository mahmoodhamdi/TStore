import 'package:flutter/material.dart';
import 'package:t_store/core/common/view_models/brand_title_with_verification_view_model.dart';
import 'package:t_store/core/common/view_models/product_title_text_view_model.dart';
import 'package:t_store/core/common/view_models/rounded_image_view_model.dart';
import 'package:t_store/core/common/widgets/brand_title_with_verification.dart';
import 'package:t_store/core/common/widgets/product_title_text.dart';
import 'package:t_store/core/common/widgets/rounded_image.dart';
import 'package:t_store/core/utils/constants/colors.dart';
import 'package:t_store/core/utils/constants/image_strings.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/helpers/helper_functions.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key});
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Row(
      children: [
        RoundedImage(
          roundedImageModel: RoundedImageModel(
            image: TImages.productImage5,
            width: 60,
            height: 60,
            padding: const EdgeInsets.all(TSizes.sm),
            backgroundColor: dark ? TColors.darkerGrey : TColors.light,
          ),
        ),
        const SizedBox(
          width: TSizes.spaceBtwItems,
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BrandTitleWithVerification(
                  brandTitleWithVerificationModel:
                      BrandTitleWithVerificationModel(
                brandName: "Nike",
              )),
              Flexible(
                child: ProductTitleText(
                    productTitleTextModel: ProductTitleTextModel(
                        title: "Green Nike Sports Jacket", maxLines: 1)),
              ),
              Text.rich(TextSpan(children: [
                TextSpan(
                    text: "Color ",
                    style: Theme.of(context).textTheme.bodySmall),
                TextSpan(
                    text: "Green ",
                    style: Theme.of(context).textTheme.bodyLarge),
                TextSpan(
                    text: "Size ",
                    style: Theme.of(context).textTheme.bodySmall),
                TextSpan(
                    text: "UK 08", style: Theme.of(context).textTheme.bodyLarge)
              ])),
            ],
          ),
        )
      ],
    );
  }
}
