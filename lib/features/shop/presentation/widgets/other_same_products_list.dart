import 'package:flutter/material.dart';
import 'package:t_store/core/common/view_models/rounded_image_view_model.dart';
import 'package:t_store/core/common/widgets/rounded_image.dart';
import 'package:t_store/core/utils/constants/colors.dart';
import 'package:t_store/core/utils/constants/image_strings.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/helpers/helper_functions.dart';

class OtherSameProductsList extends StatelessWidget {
  const OtherSameProductsList({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Positioned(
      right: 0,
      bottom: 30,
      left: TSizes.defaultSpace,
      child: SizedBox(
        height: 80,
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) => RoundedImage(
                roundedImageModel: RoundedImageModel(
                    image: TImages.productImage5,
                    width: 80,
                    border: Border.all(
                      color: TColors.primary,
                    ),
                    backgroundColor: dark ? TColors.dark : TColors.white,
                    padding: const EdgeInsets.all(TSizes.sm))),
            separatorBuilder: (context, index) => const SizedBox(
                  width: TSizes.spaceBtwItems,
                ),
            itemCount: 6),
      ),
    );
  }
}
