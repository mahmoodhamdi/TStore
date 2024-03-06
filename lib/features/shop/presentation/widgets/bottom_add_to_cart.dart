import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/core/common/models/circular_icon_model.dart';
import 'package:t_store/core/common/widgets/circular_icon.dart';
import 'package:t_store/core/utils/constants/colors.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/helpers/helper_functions.dart';

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
