import 'package:flutter/material.dart';

class UserProfileTileModel {
  final String title;
  final String subtitle;
  final IconData trailing;
  final String leading;
  final bool isNetworkImage;
  final void Function()? onTap;
  const UserProfileTileModel({
    this.onTap,
    this.isNetworkImage = false,
    required this.title,
    required this.subtitle,
    required this.trailing,
    required this.leading,
  });
}
