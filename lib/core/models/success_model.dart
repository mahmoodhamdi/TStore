import 'package:flutter/material.dart';

class SuccessModel{
   final String image, title, subTitle, buttonText;
  final VoidCallback onPressed;
  SuccessModel({
    required this.buttonText,
    required this.image,
    required this.title,
    required this.subTitle,
    required this.onPressed
  });
}