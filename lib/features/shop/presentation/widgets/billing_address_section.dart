import 'package:flutter/material.dart';
import 'package:t_store/core/common/models/section_heading_model.dart';
import 'package:t_store/core/common/widgets/section_heading.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/helpers/helper_functions.dart';

class BillingAddressSection extends StatelessWidget {
  const BillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeading(
          sectionHeadingModel: SectionHeadingModel(
            title: "Shipping Address",
            actionButtonOnPressed: () {},
            showActionButton: true,
            actionButtonTitle: "Change",
          ),
        ),
        Text("Code With Me ", style: Theme.of(context).textTheme.bodyLarge),
        Row(
          children: [
            const Icon(
              Icons.phone,
              size: 16,
              color: Colors.grey,
            ),
            const SizedBox(
              width: TSizes.spaceBtwItems,
            ),
            Text(
              "+20-123456789",
              style: Theme.of(context).textTheme.bodyMedium,
            )
          ],
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems / 2,
        ),
        Row(
          children: [
            const Icon(
              Icons.location_history,
              size: 16,
              color: Colors.grey,
            ),
            const SizedBox(
              width: TSizes.spaceBtwItems,
            ),
            Text(
              "123 Street, Egypt",
              softWrap: true,
              style: Theme.of(context).textTheme.bodyMedium,
            )
          ],
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems / 2,
        ),
      ],
    );
  }
}
