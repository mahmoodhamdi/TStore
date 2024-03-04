import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/core/utils/constants/image_strings.dart';
import 'package:t_store/core/utils/constants/text_strings.dart';
import 'package:t_store/features/auth/presentation/models/on_boarding_model.dart';
import 'package:t_store/features/auth/presentation/cubit/on_boarding_cubit.dart';
import 'package:t_store/features/auth/presentation/widgets/on_boarding_dot_navigation.dart';
import 'package:t_store/features/auth/presentation/widgets/on_boarding_next_button.dart';
import 'package:t_store/features/auth/presentation/widgets/on_boarding_page.dart';
import 'package:t_store/features/auth/presentation/widgets/on_boarding_skip_button.dart';

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnBoardingCubit, OnBoardingState>(
      builder: (context, state) {
        final onBoardingCubit = context.read<OnBoardingCubit>();
        final pageController = onBoardingCubit.pageController;
        return Scaffold(
          body: Stack(
            children: [
              PageView(
                controller: pageController,
                onPageChanged: (index) {
                  context.read<OnBoardingCubit>().updatePageIndicator(index);
                },
                physics: const BouncingScrollPhysics(),
                children: [
                  OnBoardingPage(
                    onBoardingModel: OnBoardingModel(
                      image: TImages.onBoardingImage1,
                      title: TTexts.onBoardingTitle1,
                      subTitle: TTexts.onBoardingSubTitle1,
                    ),
                  ),
                  OnBoardingPage(
                    onBoardingModel: OnBoardingModel(
                      image: TImages.onBoardingImage2,
                      title: TTexts.onBoardingTitle2,
                      subTitle: TTexts.onBoardingSubTitle2,
                    ),
                  ),
                  OnBoardingPage(
                    onBoardingModel: OnBoardingModel(
                      image: TImages.onBoardingImage3,
                      title: TTexts.onBoardingTitle3,
                      subTitle: TTexts.onBoardingSubTitle3,
                    ),
                  ),
                ],
              ),
              const OnBoardingSkipButton(),
              const OnBoardingDotNavigation(),
              const OnBoardingNextButton()
            ],
          ),
        );
      },
    );
  }
}
