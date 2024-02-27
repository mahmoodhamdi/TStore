import 'package:flutter/material.dart';

import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/sizes.dart';
import '../../../../core/utils/constants/text_strings.dart';
import '../../../../core/utils/helpers/helper_functions.dart';

class TermsAndPrivacyAgreement extends StatelessWidget {
  const TermsAndPrivacyAgreement({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Row(
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Checkbox(
            value: true,
            onChanged: (value) {},
          ),
        ),
        const SizedBox(
          width: TSizes.spaceBtwInputFields - 8,
        ),
        Text.rich(TextSpan(children: [
          const TextSpan(text: TTexts.iAgreeTo),
          TextSpan(
              text: " ${TTexts.privacyPolicy} ",
              style: Theme.of(context).textTheme.bodyMedium!.apply(
                    decoration: TextDecoration.underline,
                    decorationColor: dark ? TColors.white : TColors.primary,
                    color: dark ? TColors.white : TColors.primary,
                  )),
          const TextSpan(text: TTexts.and),
          TextSpan(
              text: " ${TTexts.termsOfUse}",
              style: Theme.of(context).textTheme.bodyMedium!.apply(
                    decoration: TextDecoration.underline,
                    decorationColor: dark ? TColors.white : TColors.primary,
                    color: dark ? TColors.white : TColors.primary,
                  )),
        ]))
      ],
    );
  }
}
