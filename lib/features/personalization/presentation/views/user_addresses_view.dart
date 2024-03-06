import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/core/common/models/app_bar_model.dart';
import 'package:t_store/core/common/widgets/app_bar.dart';
import 'package:t_store/core/utils/constants/colors.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/helpers/helper_functions.dart';
import 'package:t_store/features/personalization/presentation/models/single_address_model.dart';
import 'package:t_store/features/personalization/presentation/views/add_new_addresses_view.dart';
import 'package:t_store/features/personalization/presentation/widgets/single_address.dart';

class UserAddressesView extends StatelessWidget {
  const UserAddressesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: TColors.primary,
        onPressed: () {
          THelperFunctions.navigateToScreen(
              context, const AddNewAddressesView());
        },
        child: const Icon(Iconsax.add, color: TColors.white),
      ),
      appBar: CustomAppBar(
          appBarModel: AppBarModel(
              hasArrowBack: true,
              title: Text(
                "Addresses",
                style: Theme.of(context).textTheme.headlineSmall,
              ))),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              SingleAddress(
                singleAddressModel: SingleAddressModel(
                    name: "Mahmoud Hamdy",
                    phoneNumber: "0123456789",
                    address: "8th of October,Cairo,Egypt",
                    isSelected: true),
              ),
              SingleAddress(
                singleAddressModel: SingleAddressModel(
                    name: "Mahmoud Hamdy",
                    phoneNumber: "0123456789",
                    address: "8th of October,Cairo,Egypt",
                    isSelected: false),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
