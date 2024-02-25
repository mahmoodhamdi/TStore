import 'package:flutter/material.dart';
import 'package:t_store/features/shop/data/models/circular_container_model.dart';

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
      decoration: BoxDecoration(
        color: circularContainerModel.color,
        borderRadius:
            BorderRadius.circular(circularContainerModel.borderRadius!),
      ),
      padding: EdgeInsets.all(circularContainerModel.padding!),
      child: circularContainerModel.child,
    );
  }
}
