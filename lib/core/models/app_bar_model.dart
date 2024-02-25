//app bar Model

import 'package:flutter/material.dart';

class AppBarModel {
  final bool centerTitle;
  final bool? hasArrowBack;
  final Widget? title;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;

  AppBarModel({
    this.centerTitle = false,
    this.hasArrowBack = false,
    this.title,
    this.leadingIcon,
    this.actions,
    this.leadingOnPressed,
  });
}
