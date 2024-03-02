import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/core/models/brand_card_model.dart';
import 'package:t_store/core/models/circular_container_model.dart';
import 'package:t_store/core/utils/constants/colors.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/helpers/helper_functions.dart';
import 'package:t_store/core/widgets/circular_container.dart';

class BrandCard extends StatelessWidget {
  const BrandCard({super.key, required this.brandCardModel});
  final BrandCardModel brandCardModel;
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: brandCardModel.onTap,
      child: CircularContainer(
        circularContainerModel: CircularContainerModel(
            showBorder: brandCardModel.showBorder,
            color: Colors.transparent,
            padding: const EdgeInsets.all(TSizes.sm),
            child: Flexible(
              child: Row(
                children: [
                  Image(
                    height: 50,
                    width: 50,
                    image: AssetImage(brandCardModel.image),
                    color: dark ? TColors.white : TColors.black,
                  ),
                  const SizedBox(
                    width: TSizes.spaceBtwItems / 2,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            brandCardModel.brandName,
                            style: Theme.of(context).textTheme.titleLarge,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const Icon(
                            Iconsax.verify5,
                            size: TSizes.iconXs,
                            color: TColors.primary,
                          )
                        ],
                      ),
                      Text(
                        "${brandCardModel.productCount} Products",
                        style: Theme.of(context).textTheme.labelMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  )
                ],
              ),
            )
            // ListTile(
            //   title: FittedBox(
            //     fit: BoxFit.scaleDown,
            //     child: Row(
            //       children: [
            //         Text(brandCardModel.brandName,
            //             style: Theme.of(context).textTheme.headlineLarge),
            //         const SizedBox(
            //           width: TSizes.spaceBtwItems / 10,
            //         ),
            //         if (brandCardModel.isVerified)
            //           const Icon(
            //             size: 25,
            //             Iconsax.verify5,
            //             color: TColors.primary,
            //           )
            //       ],
            //     ),
            //   ),
            //   subtitle: FittedBox(
            //       fit: BoxFit.scaleDown,
            //       child: Text("${brandCardModel.productCount} Products",
            //           style: Theme.of(context).textTheme.labelMedium)),
            //   leading: Image.asset(
            //     height: 30,
            //     brandCardModel.image,
            //     color: dark ? TColors.white : TColors.black,
            //   ),
            // )
            // //  Row(
            //   children: [
            //     Flexible(
            //       child: RoundedImage(
            //         roundedImageModel: RoundedImageModel(
            //           overlayColor: dark ? TColors.white : TColors.black,
            //           image: brandCardModel.image,
            //           isNetworkImage: false,
            //         ),
            //       ),
            //     ),
            //     const SizedBox(
            //       width: TSizes.spaceBtwItems / 2,
            //     ),
            //     Expanded(
            //         child: Column(
            //       mainAxisSize: MainAxisSize.min,
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         const Text(
            //           'Brand Name',
            //           maxLines: 1,
            //           overflow: TextOverflow.ellipsis,
            //         ),
            //         Text(
            //           '250 Products',
            //           maxLines: 1,
            //           style: Theme.of(context).textTheme.labelMedium,
            //           overflow: TextOverflow.ellipsis,
            //         ),
            //       ],
            //     ))
            //   ],
            // ),

            ),
      ),
    );
  }
}
