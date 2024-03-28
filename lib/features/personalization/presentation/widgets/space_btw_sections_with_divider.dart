import 'package:flutter/material.dart';
import 'package:t_store/core/utils/constants/sizes.dart';

class SpaceBetweenSectionsWithDivider extends StatelessWidget {
  const SpaceBetweenSectionsWithDivider({
    super.key,
  });
//SpaceBetweenSectionsWithDivider >>
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(
          height: TSizes.spaceBtwItems / 1.5,
        ),
        Divider(),
        SizedBox(
          height: TSizes.spaceBtwItems / 1.5,
        ),
      ],
    );
  }
}
