import 'package:flutter/material.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/constants/text_strings.dart';

class ForgetPasswordHeaderSection extends StatelessWidget {
  const ForgetPasswordHeaderSection({
    super.key,
  });
//ForgetPasswordHeader >> forget_password_header.dart
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(TTexts.forgetPasswordTitle,
            style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        Text(TTexts.forgetPasswordSubTitle,
            style: Theme.of(context).textTheme.labelMedium),
      ],
    );
  }
}
