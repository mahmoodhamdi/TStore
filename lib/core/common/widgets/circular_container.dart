import 'package:flutter/material.dart';
import 'package:t_store/core/common/models/circular_container_model.dart';

class CircularContainer extends StatelessWidget {
  const CircularContainer({
    super.key,
    required this.circularContainerModel,
  });
  final CircularContainerModel circularContainerModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: circularContainerModel.height,
      width: circularContainerModel.width,
      margin: (circularContainerModel.margin) ?? EdgeInsets.zero,
      decoration: BoxDecoration(
          color: circularContainerModel.color,
          borderRadius:
              BorderRadius.circular(circularContainerModel.borderRadius!),
          border: circularContainerModel.showBorder
              ? Border.all(color: circularContainerModel.borderColor)
              : null),
      padding: circularContainerModel.padding,
      child: circularContainerModel.child,
    );
  }
}
