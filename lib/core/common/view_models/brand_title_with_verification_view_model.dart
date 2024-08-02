import 'package:flutter/material.dart';
import 'package:t_store/core/utils/constants/colors.dart';

class BrandTitleWithVerificationModel {
  final String brandName;
  final Color iconColor;
  final int maxLines;
  final TextAlign textAlign;
  const BrandTitleWithVerificationModel({
    required this.brandName,
    this.iconColor = TColors.primary,
    this.maxLines = 1,
    this.textAlign = TextAlign.center,
  });
}
