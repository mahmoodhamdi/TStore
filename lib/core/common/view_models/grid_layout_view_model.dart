import 'package:flutter/material.dart';

class GridLayoutModel {
  final int itemCount;
  final Widget? Function(BuildContext, int) itemBuilder;
  final double mainAxisExtent;

  const GridLayoutModel({
    required this.itemCount,
    required this.itemBuilder,
    this.mainAxisExtent = 288,
  });
}
