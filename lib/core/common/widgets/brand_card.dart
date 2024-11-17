import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/core/common/view_models/brand_card_view_model.dart';
import 'package:t_store/core/common/view_models/circular_container_view_model.dart';
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Fixed size container for the image
              SizedBox(
                width: 40,
                height: 40,
                child: Image.asset(
                  brandCardModel.image,
                  color: dark ? TColors.white : TColors.black,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey.withOpacity(0.1),
                      child: const Icon(Icons.error_outline),
                    );
                  },
                ),
              ),
              const SizedBox(
                width: TSizes.spaceBtwItems / 2,
              ),
              // Expanded widget to ensure the text part takes up the remaining space
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Text(
                            brandCardModel.brandName,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(overflow: TextOverflow.ellipsis),
                          ),
                        ),
                        if (brandCardModel.isVerified ?? false) ...[
                          const SizedBox(width: TSizes.xs),
                          const Icon(
                            Iconsax.verify5,
                            size: TSizes.iconXs,
                            color: TColors.primary,
                          ),
                        ],
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
