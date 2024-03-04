import 'package:flutter/material.dart';
import 'package:t_store/core/common/models/section_heading_model.dart';
import 'package:t_store/core/common/widgets/section_heading.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/features/personalization/presentation/models/settings_menu_tile_model.dart';
import 'package:t_store/features/personalization/presentation/widgets/settings_menu_tile_list.dart';

class AppSettingsSection extends StatelessWidget {
  const AppSettingsSection({
    super.key,
    required this.appSettingsTiles,
  });
  final List<SettingsMenuTileModel> appSettingsTiles;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionHeading(
          sectionHeadingModel: SectionHeadingModel(
            title: "App Settings",
            showActionButton: false,
          ),
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems / 2,
        ),
        SettingsMenuTileList(settingsMenuTiles: appSettingsTiles),
        const SizedBox(
          height: TSizes.spaceBtwSections,
        ),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {},
            child: const Text("Logout"),
          ),
        ),
      ],
    );
  }
}
