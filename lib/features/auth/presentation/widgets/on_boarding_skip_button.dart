import 'package:flutter/material.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/device/device_utility.dart';

class OnBoardingSkipButton extends StatelessWidget {
  const OnBoardingSkipButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: TDeviceUtils.getAppBarHeight(),
      right: TSizes.defaultSpace,
      child: TextButton(
        onPressed: () {},
        child: const Text('Skip'),
      ),
    );
  }
}
