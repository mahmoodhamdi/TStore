import 'package:flutter/material.dart';
import 'package:t_store/core/models/circular_icon_model.dart';
import 'package:t_store/core/utils/constants/colors.dart';
import 'package:t_store/core/utils/helpers/helper_functions.dart';

class CircularIcon extends StatelessWidget {
  const CircularIcon({
    super.key,
    required this.circularIconModel,
  });
  final CircularIconModel circularIconModel;
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Container(
        height: circularIconModel.height,
        width: circularIconModel.width,
        decoration: BoxDecoration(
          color: circularIconModel.backgroundColor ??
              (dark
                  ? TColors.black.withOpacity(.9)
                  : TColors.white.withOpacity(.9)),
          borderRadius: const BorderRadius.all(
            Radius.circular(100),
          ),
        ),
        child: IconButton(
          onPressed: circularIconModel.onPressed,
          icon: Icon(
            circularIconModel.icon,
            size: circularIconModel.iconSize,
            color: circularIconModel.color,
          ),
        ));
  }
}

//circular icon model
