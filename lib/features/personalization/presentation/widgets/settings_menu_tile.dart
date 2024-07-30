import 'package:flutter/material.dart';
import 'package:t_store/core/utils/constants/colors.dart';
import 'package:t_store/features/personalization/presentation/view_models/settings_menu_tile_model.dart';

class SettingsMenuTile extends StatelessWidget {
  const SettingsMenuTile({super.key, required this.settingsMenuTileModel});
  final SettingsMenuTileModel settingsMenuTileModel;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      title: Text(
        settingsMenuTileModel.title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      onTap: settingsMenuTileModel.onTap,
      subtitle: Text(settingsMenuTileModel.subtitle,
          style: Theme.of(context).textTheme.labelMedium),
      leading: Icon(
        settingsMenuTileModel.leading,
        color: TColors.primary,
        size: 28,
      ),
      trailing: settingsMenuTileModel.trailing,
    );
  }
}
