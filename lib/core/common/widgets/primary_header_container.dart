import 'package:flutter/material.dart';
import 'package:t_store/core/common/models/circular_container_model.dart';
import 'package:t_store/core/utils/constants/colors.dart';
import 'package:t_store/core/common/widgets/circular_container.dart';
import 'package:t_store/core/common/widgets/curved_widget.dart';

class PrimaryHeaderContainer extends StatelessWidget {
  const PrimaryHeaderContainer({
    super.key,
    required this.child,
  });
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return CurvedWidget(
      child: Container(
        color: TColors.primary,
        padding: EdgeInsets.zero,
        child: SizedBox(
           child: Stack(
            children: [
              Positioned(
                top: -150,
                right: -250,
                child: CircularContainer(
                  circularContainerModel: CircularContainerModel(
                    height: 400,
                    width: 400,
                    borderRadius: 400,
                    color: TColors.textWhite.withOpacity(0.1),
                  ),
                ),
              ),
              Positioned(
                  right: -300,
                  top: 100,
                  child: CircularContainer(
                      circularContainerModel: CircularContainerModel(
                    height: 400,
                    width: 400,
                    borderRadius: 400,
                    color: TColors.textWhite.withOpacity(0.1),
                  ))),
              child
            ],
          ),
        ),
      ),
    );
  }
}
