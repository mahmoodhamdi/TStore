//SettingsMenuTileList >> settings_menu_tile.dart
import 'package:flutter/material.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/features/personalization/presentation/models/settings_menu_tile_model.dart';
import 'package:t_store/features/personalization/presentation/widgets/settings_menu_tile.dart';

class SettingsMenuTileList extends StatelessWidget {
  const SettingsMenuTileList({super.key, required this.settingsMenuTiles});
  final List<SettingsMenuTileModel> settingsMenuTiles;
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: TSizes.md),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: settingsMenuTiles
          .map((e) => SettingsMenuTile(settingsMenuTileModel: e))
          .toList(),
    );
  }
}
