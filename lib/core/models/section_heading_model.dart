//Section Heading Model >>
import 'package:flutter/material.dart';
import 'package:t_store/core/utils/constants/text_strings.dart';

class SectionHeadingModel {
  final Color? textColor;
  final bool showActionButton;
  final String title, actionButtonTitle;
  final Function()? actionButtonOnPressed;

  SectionHeadingModel(
      {this.textColor,
      this.showActionButton = true,
      required this.title,
      this.actionButtonTitle = TTexts.viewAll,
      this.actionButtonOnPressed});
}
