import 'package:flutter/material.dart';
import 'package:t_store/core/utils/constants/colors.dart';

class TabBarModel {
  final List<Widget> tabs;
  final bool isScrollable;
  final TabController? tabController;
  final Color indicatorColor;
  final Color unselectedLabelColor;
  final Color labelColor;
  final Color backgroundColor;

  TabBarModel({
    required this.tabs,
    this.isScrollable = false,
    this.tabController,
    this.indicatorColor = TColors.primary,
    this.unselectedLabelColor = TColors.darkGrey,
    this.labelColor = TColors.primary,
    this.backgroundColor = TColors.white,
  });
}
