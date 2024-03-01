import 'package:flutter/material.dart';

class ProductTitleTextModel {
  //ProductTitleTextModel >> product_title_text_model.dart
  final String title;
  final bool smallSize;
  final int maxLines;
  final TextAlign? textAlign;
  final TextOverflow? overflow;

  ProductTitleTextModel({
    required this.title,
    this.smallSize = false,
    this.maxLines = 2,
    this.textAlign = TextAlign.left,
    this.overflow,
  });
}
