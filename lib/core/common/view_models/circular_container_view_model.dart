import 'package:flutter/material.dart';
import 'package:t_store/core/utils/constants/colors.dart';
import 'package:t_store/core/utils/constants/sizes.dart';

class CircularContainerModel {
  final double? width;
  final double? height;
  final Color? color;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;
  final Widget? child;
  final bool showBorder;
  final Color borderColor;
  final EdgeInsetsGeometry? margin;

  CircularContainerModel(
      {this.width,
      this.borderColor = TColors.borderPrimary,
      this.showBorder = false,
      this.margin,
      this.child,
      this.height,
      this.color = TColors.white,
      this.borderRadius = TSizes.cardRadiusLg,
      this.padding = EdgeInsets.zero});
}
