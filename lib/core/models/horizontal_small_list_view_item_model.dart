import 'package:flutter/material.dart';
import 'package:t_store/core/utils/constants/colors.dart';

class HorizontalSmallListViewItemModel {
  final String title;
  final String image;
  final Color textColor;
  final Color ?backgroundColor;
  final void Function()? onTap;

  HorizontalSmallListViewItemModel({
    required this.title,
    required this.image,
     this.textColor=TColors.white,
     this.backgroundColor,
    this.onTap,
  });
}

//horizontal small list view item model>> horizontal_small_list_view_item_model.dart
