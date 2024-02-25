import 'package:flutter/material.dart';
import 'package:t_store/core/utils/constants/colors.dart';

class CircularContainerModel {
  final double? width;
  final double? height;
  final Color? color;
  final double? borderRadius;
  final double? padding;
  final Widget? child;

  CircularContainerModel(
      {this.width = 400,
      this.child,
      this.height = 400,
      this.color = TColors.primary,
      this.borderRadius = 400,
      this.padding = 0});
}
