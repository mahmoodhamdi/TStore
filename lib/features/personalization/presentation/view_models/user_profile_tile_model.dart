import 'package:flutter/material.dart';

class UserProfileTileModel {
  final String title;
  final String subtitle;
  final IconData trailing;
  final String leading;
  final void Function()? onTap;
  const UserProfileTileModel({
    this.onTap,
    required this.title,
    required this.subtitle,
    required this.trailing,
    required this.leading,
  });
}
