import 'package:flutter/material.dart';
import 'package:t_store/core/utils/constants/colors.dart';
import 'package:t_store/core/utils/helpers/helper_functions.dart';
import 'package:t_store/features/shop/presentation/view_models/rating_progress_indicator_model.dart';

class RatingProgressIndicator extends StatelessWidget {
  const RatingProgressIndicator({
    super.key,
    required this.progressIndicatorModel,
  });
  final RatingProgressIndicatorModel progressIndicatorModel;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            progressIndicatorModel.text,
            maxLines: 1,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        Expanded(
            flex: 11,
            child: SizedBox(
              width: THelperFunctions.screenWidth(context) * 0.8,
              child: LinearProgressIndicator(
                value: progressIndicatorModel.value,
                backgroundColor: TColors.grey,
                minHeight: 11,
                borderRadius: BorderRadius.circular(7),
                valueColor: const AlwaysStoppedAnimation(TColors.primary),
              ),
            ))
      ],
    );
  }
}


