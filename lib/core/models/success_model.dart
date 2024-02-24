import 'package:flutter/material.dart';

class SuccessModel{
   final String image, title, subTitle;
  final VoidCallback onPressed;
  SuccessModel({
    required this.image,
    required this.title,
    required this.subTitle,
    required this.onPressed
  });
}