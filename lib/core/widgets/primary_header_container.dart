import 'package:flutter/material.dart';
import 'package:t_store/core/utils/constants/colors.dart';
import 'package:t_store/core/widgets/curved_widget.dart';
import 'package:t_store/core/models/circular_container_model.dart';
import 'package:t_store/core/widgets/circular_container.dart';

class PrimaryHeaderContainer extends StatelessWidget {
  const PrimaryHeaderContainer({
    super.key, required this.child,
  });
final Widget child;
  @override
  Widget build(BuildContext context) {
    return CurvedWidget(
      child: Container(

        color: TColors.primary,
        padding: EdgeInsets.zero,
        child: SizedBox(
          height: 400,
          child: Stack(
            children: [
              Positioned(
                top: -150,
                right: -250,
                child: CircularContainer(
                  circularContainerModel: CircularContainerModel(
                    color: TColors.textWhite.withOpacity(0.1),
                    borderRadius: 400,
                    child: Container(),
                  ),
                ),
              ),
              Positioned(
                top: 100,
                right: -300,
                child: CircularContainer(
                  circularContainerModel: CircularContainerModel(
                    color: TColors.textWhite.withOpacity(0.1),
                    borderRadius: 400,
                  ),
                ),
              ),
              child
            ],
          ),
        ),
      ),
    );
  }
}
