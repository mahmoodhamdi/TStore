import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:t_store/core/utils/constants/colors.dart';

class ReadMore extends StatelessWidget {
  const ReadMore({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return ReadMoreText(
      text,
      trimLines: 2,
      trimExpandedText: "Show Less",
      trimMode: TrimMode.Line,
      trimCollapsedText: "Show More",
      moreStyle: const TextStyle(
          fontWeight: FontWeight.w800, fontSize: 14, color: TColors.primary),
      lessStyle: const TextStyle(
          fontWeight: FontWeight.w800, fontSize: 14, color: TColors.primary),
    );
  }
}
