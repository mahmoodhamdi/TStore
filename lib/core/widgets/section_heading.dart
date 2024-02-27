import 'package:flutter/material.dart';
import 'package:t_store/core/models/section_heading_model.dart';

class SectionHeading extends StatelessWidget {
  const SectionHeading({
    super.key,
    required this.sectionHeadingModel,
  });
  final SectionHeadingModel sectionHeadingModel;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          sectionHeadingModel.title,
          style: Theme.of(context).textTheme.headlineSmall!.apply(
                color: sectionHeadingModel.textColor,
              ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        if (sectionHeadingModel.showActionButton)
          TextButton(
            onPressed: sectionHeadingModel.actionButtonOnPressed,
            child: Text(
              sectionHeadingModel.actionButtonTitle,
            ),
          ),
      ],
    );
  }
}
