import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/core/common/models/circular_container_model.dart';
import 'package:t_store/core/common/widgets/circular_container.dart';
import 'package:t_store/core/utils/constants/colors.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/helpers/helper_functions.dart';
import 'package:t_store/features/personalization/presentation/view_models/single_address_model.dart';

class SingleAddress extends StatelessWidget {
  const SingleAddress({super.key, required this.singleAddressModel});
  final SingleAddressModel singleAddressModel;
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return CircularContainer(
      circularContainerModel: CircularContainerModel(
          padding: const EdgeInsets.all(TSizes.md),
          width: double.infinity,
          showBorder: true,
          color: singleAddressModel.isSelected
              ? TColors.primary.withOpacity(.5)
              : Colors.transparent,
          borderColor: singleAddressModel.isSelected
              ? Colors.transparent
              : dark
                  ? TColors.darkerGrey
                  : TColors.grey,
          margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
          child: Stack(
            children: [
              Positioned(
                right: 5,
                top: 0,
                child: Icon(
                  singleAddressModel.isSelected ? Iconsax.tick_circle5 : null,
                  color: singleAddressModel.isSelected
                      ? dark
                          ? TColors.light
                          : TColors.dark //.withOpacity(.6)
                      : null,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    singleAddressModel.name,
                    style: Theme.of(context).textTheme.titleLarge,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: TSizes.sm / 2,
                  ),
                  Text(
                    singleAddressModel.phoneNumber,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: TSizes.sm / 2,
                  ),
                  Text(
                    singleAddressModel.address,
                    softWrap: true,
                  ),
                ],
              )
            ],
          )),
    );
  }
}
