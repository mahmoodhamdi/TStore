import 'package:flutter/material.dart';
import 'package:t_store/core/common/view_models/circular_container_view_model.dart';
import 'package:t_store/core/common/widgets/circular_container.dart';
import 'package:t_store/core/utils/constants/colors.dart';
import 'package:t_store/core/utils/constants/sizes.dart';

class SaleTag extends StatelessWidget {
  const SaleTag({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CircularContainer(
        circularContainerModel: CircularContainerModel(
      padding: const EdgeInsets.symmetric(
          horizontal: TSizes.sm, vertical: TSizes.xs),
      borderRadius: TSizes.sm,
      color: TColors.secondary.withOpacity(.8),
      child: Text(
        "25%",
        style:
            Theme.of(context).textTheme.labelLarge!.apply(color: TColors.black),
      ),
    ));
  }
}
