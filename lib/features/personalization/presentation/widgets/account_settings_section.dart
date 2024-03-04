import 'package:flutter/material.dart';
import 'package:t_store/core/common/models/section_heading_model.dart';
import 'package:t_store/core/common/widgets/section_heading.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/features/personalization/presentation/models/settings_menu_tile_model.dart';
import 'package:t_store/features/personalization/presentation/widgets/settings_menu_tile_list.dart';

class AccountSettingsSection extends StatelessWidget {
  const AccountSettingsSection({
    super.key,
    required this.accountSettingsTiles,
  });
  final List<SettingsMenuTileModel> accountSettingsTiles;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionHeading(
            sectionHeadingModel: SectionHeadingModel(
          title: "Account Settings",
          showActionButton: false,
        )),
        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        SettingsMenuTileList(settingsMenuTiles: accountSettingsTiles),
      ],
    );
  }
}
