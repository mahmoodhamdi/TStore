import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:t_store/core/utils/constants/colors.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/device/device_utility.dart';
import 'package:t_store/core/utils/helpers/helper_functions.dart';
import 'package:t_store/features/auth/presentation/logic/on_boarding/on_boarding_cubit.dart';

class OnBoardingDotNavigation extends StatelessWidget {
  const OnBoardingDotNavigation({
    super.key,
   });
   @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Positioned(
      bottom: TDeviceUtils.getBottomNavigationBarHeight() + 25,
      left: TSizes.defaultSpace,
      child: SmoothPageIndicator(
          controller: context.read<OnBoardingCubit>().pageController,
          count: 3,
          axisDirection: Axis.horizontal,
          onDotClicked: (index) {
          context.read<OnBoardingCubit>().dotNavigationClicked(index);
          },
          effect: ExpandingDotsEffect(
            dotHeight: 6,
            activeDotColor: dark ? TColors.light : TColors.dark,
          )),
    );
  }
}
