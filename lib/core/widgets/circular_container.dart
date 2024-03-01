import 'package:flutter/material.dart';
import 'package:t_store/core/models/circular_container_model.dart';

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
      ),
      padding: circularContainerModel.padding,
      child: circularContainerModel.child,
    );
  }
}
