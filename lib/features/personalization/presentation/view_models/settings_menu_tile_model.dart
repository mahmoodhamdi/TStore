//SettingsMenuTileModel
import 'package:flutter/material.dart';

class SettingsMenuTileModel {
  final String title;
  final String subtitle;
  final IconData leading;
  final Widget ?trailing;
  final void Function() onTap;
  const SettingsMenuTileModel({
    required this.title,
    required this.onTap,
    required this.subtitle,
    required this.leading,
      this.trailing,
  });
}
