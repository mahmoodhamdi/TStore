import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/core/common/models/brand_card_model.dart';
import 'package:t_store/core/common/models/circular_container_model.dart';
import 'package:t_store/core/common/widgets/circular_container.dart';
import 'package:t_store/core/utils/constants/colors.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/helpers/helper_functions.dart';

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
          child: Row(
            children: [
              Image(
                width: 50,
                image: AssetImage(brandCardModel.image),
                color: dark ? TColors.white : TColors.black,
              ),
              const SizedBox(
                width: TSizes.spaceBtwItems / 2,
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Text(
                            brandCardModel.brandName,
                            style: Theme.of(context).textTheme.titleLarge,
                            overflow: TextOverflow.ellipsis,
                          ),
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
