import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/core/common/widgets/primary_header_container.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/helpers/helper_functions.dart';
import 'package:t_store/features/personalization/presentation/models/settings_menu_tile_model.dart';
import 'package:t_store/features/personalization/presentation/views/user_addresses_view.dart';
import 'package:t_store/features/personalization/presentation/widgets/account_settings_section.dart';
import 'package:t_store/features/personalization/presentation/widgets/app_settings_section.dart';
import 'package:t_store/features/personalization/presentation/widgets/settings_view_header_section.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<SettingsMenuTileModel> appSettingsTiles = [
      SettingsMenuTileModel(
        onTap: () {},
        title: "Upload Data",
        subtitle: "Upload Your Data To Server",
        leading: Iconsax.document_upload,
      ),
      SettingsMenuTileModel(
        onTap: () {},
        title: "Geolocation",
        subtitle: "Set Recommendation Based On Location",
        leading: Iconsax.document_download,
        trailing: Switch(
          value: true,
          onChanged: (value) {},
        ),
      ),
      SettingsMenuTileModel(
        onTap: () {},
        title: "Safe Mode",
        subtitle: "Search Result Is Safe For All Ages",
        leading: Iconsax.security_user,
        trailing: Switch(
          value: false,
          onChanged: (value) {},
        ),
      ),
      SettingsMenuTileModel(
        onTap: () {},
        title: "HD Image Quality",
        subtitle: "Set Image Quality To High Quality",
        leading: Iconsax.image,
        trailing: Switch(
          value: true,
          onChanged: (value) {},
        ),
      ),
    ];
    final List<SettingsMenuTileModel> accountSettingsTiles = [
      SettingsMenuTileModel(
        onTap: () {
          //navigateToScreen UserAddressesView
          THelperFunctions.navigateToScreen(context, const UserAddressesView());
        },
        title: "My Addresses",
        subtitle: "Set Shopping Delivery Address",
        leading: Iconsax.safe_home,
      ),
      SettingsMenuTileModel(
        onTap: () {},
        title: "My Cart",
        subtitle: "Add, Remove Products And Move To Checkout",
        leading: Iconsax.shopping_cart,
      ),
      SettingsMenuTileModel(
        onTap: () {},
        title: "My Orders",
        subtitle: "In-Progress And Completed Orders",
        leading: Iconsax.bag,
      ),
      SettingsMenuTileModel(
        onTap: () {},
        title: "Bank Account",
        subtitle: "WithDraw Balance To Registered Bank Account",
        leading: Iconsax.bank,
      ),
      SettingsMenuTileModel(
        onTap: () {},
        title: "My Coupons",
        subtitle: "List Of All Discounted Coupons",
        leading: Iconsax.discount_shape,
      ),
      SettingsMenuTileModel(
        onTap: () {},
        title: "Notifications",
        subtitle: "Set Any Kind Of Notifications Message",
        leading: Iconsax.notification,
      ),
      SettingsMenuTileModel(
        onTap: () {},
        title: "Account Privacy",
        subtitle: "Manage Data Usage And Connected Accounts",
        leading: Iconsax.security_card,
      ),
    ];
    return SingleChildScrollView(
      child: Column(
        children: [
          const PrimaryHeaderContainer(child: SettingsViewHeaderSection()),
          Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              children: [
                AccountSettingsSection(
                    accountSettingsTiles: accountSettingsTiles),
                const SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
                AppSettingsSection(appSettingsTiles: appSettingsTiles),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
