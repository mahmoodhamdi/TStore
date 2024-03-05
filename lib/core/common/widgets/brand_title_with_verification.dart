//brand_title_with_verification.dart
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/core/common/models/brand_title_with_verification_model.dart';
import 'package:t_store/core/utils/constants/sizes.dart';

class BrandTitleWithVerification extends StatelessWidget {
  const BrandTitleWithVerification({
    super.key,
    required this.brandTitleWithVerificationModel,
  });
  final BrandTitleWithVerificationModel brandTitleWithVerificationModel;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            brandTitleWithVerificationModel.brandName,
            style: Theme.of(context).textTheme.titleLarge,
            maxLines: brandTitleWithVerificationModel.maxLines,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(
          width: TSizes.xs,
        ),
        Icon(
          Iconsax.verify5,
          color: brandTitleWithVerificationModel.iconColor,
          size: TSizes.iconXs,
        )
      ],
    );
  }
}
