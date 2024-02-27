import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SearchContainerModel {
  final IconData? icon;
  final String title;
  final bool showBackground, showBorder;
  final void Function()? onPressed;

  SearchContainerModel({
    this.onPressed,
    this.icon = Iconsax.search_normal,
    required this.title,
    this.showBackground = true,
    this.showBorder = true,
  });
}
