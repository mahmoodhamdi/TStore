import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/core/utils/constants/colors.dart';
import 'package:t_store/core/utils/constants/sizes.dart';

class AddToCartContainer extends StatelessWidget {
  const AddToCartContainer({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: TColors.dark,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(TSizes.cardRadiusMd),
          bottomRight: Radius.circular(TSizes.productImageRadius),
        ),
      ),
      child: SizedBox(
        width: TSizes.iconLg * 1.2,
        height: TSizes.iconLg * 1.2,
        child: Center(
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Iconsax.add),
            color: TColors.white,
          ),
        ),
      ),
    );
  }
}
