import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/core/common/models/circular_icon_model.dart';
import 'package:t_store/core/common/widgets/circular_icon.dart';
import 'package:t_store/core/utils/constants/colors.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/helpers/helper_functions.dart';

class ProductQuantityWithAddAndRemoveButtons extends StatelessWidget {
  const ProductQuantityWithAddAndRemoveButtons({
    super.key,
  });
//ProductQuantityWithAddAndRemoveButtons >>
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircularIcon(
          circularIconModel: CircularIconModel(
            icon: Iconsax.minus,
            width: 32,
            height: 32,
            iconSize: TSizes.md,
            color: dark ? TColors.white : TColors.dark,
            backgroundColor: dark ? TColors.darkerGrey : TColors.light,
          ),
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
            width: 32,
            height: 32,
            iconSize: TSizes.md,
            color: TColors.white,
            backgroundColor: TColors.primary,
          ),
        ),
      ],
    );
  }
}
