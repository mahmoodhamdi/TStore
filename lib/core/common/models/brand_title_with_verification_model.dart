import 'package:flutter/material.dart';
import 'package:t_store/core/utils/constants/colors.dart';
import 'package:t_store/core/utils/constants/enums.dart';

class BrandTitleWithVerificationModel {
  final String brandName;
  final Color iconColor;
  final int maxLines;
  final TextSizes textSizes;
  final TextAlign textAlign;
  const BrandTitleWithVerificationModel({
    required this.brandName,
    this.iconColor = TColors.primary,
    this.maxLines = 1,
    this.textSizes = TextSizes.small,
    this.textAlign = TextAlign.center,
  });
}
