import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/core/common/models/brand_title_with_verification_model.dart';
import 'package:t_store/core/common/models/circular_container_model.dart';
import 'package:t_store/core/common/models/circular_icon_model.dart';
import 'package:t_store/core/common/models/product_price_text_model.dart';
import 'package:t_store/core/common/models/product_title_text_model.dart';
import 'package:t_store/core/common/models/rounded_image_model.dart';
import 'package:t_store/core/common/widgets/add_to_cart_container.dart';
import 'package:t_store/core/common/widgets/brand_title_with_verification.dart';
import 'package:t_store/core/common/widgets/circular_container.dart';
import 'package:t_store/core/common/widgets/circular_icon.dart';
import 'package:t_store/core/common/widgets/product_price_text.dart';
import 'package:t_store/core/common/widgets/product_title_text.dart';
import 'package:t_store/core/common/widgets/rounded_image.dart';
import 'package:t_store/core/common/widgets/sale_tag.dart';
import 'package:t_store/core/utils/constants/colors.dart';
import 'package:t_store/core/utils/constants/enums.dart';
import 'package:t_store/core/utils/constants/image_strings.dart';
import 'package:t_store/core/utils/constants/shadow_styles.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/helpers/helper_functions.dart';
import 'package:t_store/features/shop/presentation/views/product_details_view.dart';

class VerticalProductCard extends StatelessWidget {
  const VerticalProductCard({super.key});
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: () {
        THelperFunctions.navigateToScreen(context, const ProductDetailsView());
      },
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
            boxShadow: [TShadowStyle.verticalProductCardShadow],
            borderRadius: const BorderRadius.all(
              Radius.circular(TSizes.productImageRadius),
            ),
            color: dark ? TColors.darkerGrey : TColors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircularContainer(
              circularContainerModel: CircularContainerModel(
                  padding: const EdgeInsets.all(TSizes.sm),
                  height: 180,
                  color: dark ? TColors.dark : TColors.light,
                  child: Stack(
                    children: [
                      RoundedImage(
                        roundedImageModel: RoundedImageModel(
                            backgroundColor:
                                dark ? TColors.dark : TColors.light,
                            image: TImages.productImage1,
                            onTap: () {},
                            applyImageRadius: true),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SaleTag(),
                          CircularIcon(
                            circularIconModel: CircularIconModel(
                              height: TSizes.iconLg * 1.2,
                              width: TSizes.iconLg * 1.2,
                              iconSize: TSizes.iconMd,
                              icon: Iconsax.heart5,
                              color: Colors.red,
                              backgroundColor:
                                  dark ? TColors.darkerGrey : TColors.white,
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
            ),
            Padding(
                padding: const EdgeInsets.only(left: TSizes.sm),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProductTitleText(
                        productTitleTextModel: ProductTitleTextModel(
                            title: "Product Title", smallSize: true),
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwItems / 2,
                      ),
                      const BrandTitleWithVerification(
                          brandTitleWithVerificationModel:
                              BrandTitleWithVerificationModel(
                                  brandName: "Nike",
                                  textSizes: TextSizes.medium)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ProductPriceText(
                            productPriceTextModel: ProductPriceTextModel(
                              currencySymbol: "\$",
                              price: "120",
                              maxLines: 1,
                            ),
                          ),
                          const AddToCartContainer()
                        ],
                      ),
                    ]))
          ],
        ),
      ),
    );
  }
}
