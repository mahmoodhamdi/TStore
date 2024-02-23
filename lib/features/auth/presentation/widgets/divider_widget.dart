import 'package:flutter/material.dart';
import 'package:t_store/core/utils/constants/colors.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/constants/text_strings.dart';
import 'package:t_store/core/utils/helpers/helper_functions.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: TSizes.spaceBtwSections),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Divider(
              color: dark ? TColors.darkGrey : TColors.grey,
              thickness: .5,
              indent: 60,
              endIndent: 5,
            ),
          ),
          Text(
            TTexts.orSignInWith,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          Flexible(
            child: Divider(
              color: dark ? TColors.darkGrey : TColors.grey,
              thickness: .5,
              indent: 5,
              endIndent: 60,
            ),
          ),
        ],
      ),
    );
  }
}
