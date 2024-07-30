import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ProfileEntityTileModel {
  final String title;
  final String value;
  final void Function()? onTap;
  final IconData trailing;
  const ProfileEntityTileModel({
    required this.value,
    required this.title,
    this.trailing = Iconsax.arrow_right_34,
    this.onTap,
  });
}
