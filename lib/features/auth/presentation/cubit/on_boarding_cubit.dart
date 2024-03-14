// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:t_store/core/utils/helpers/helper_functions.dart';
import 'package:t_store/features/auth/presentation/views/login/login_view.dart';

part 'on_boarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit() : super(OnBoardingInitial());
  final PageController pageController = PageController();
  int currentIndex = 0;
  void dotNavigationClicked(int index) {
    currentIndex = index;
    pageController.jumpToPage(index);
    emit(OnBoardingUpdateIndicator());
  }

  goToNextPage(BuildContext context) {
    if (currentIndex != 2) {
      currentIndex++;

      pageController.jumpToPage(currentIndex);
      emit(OnBoardingUpdateIndicator());
    } else {
      final deviceStorage = GetStorage();
      deviceStorage.write('isFirstTime', false);
      emit(OnBoardingUpdateIndicator());
      THelperFunctions.navigateReplacementToScreen(context, const LoginView());
    }
  }

  void updatePageIndicator(int index) {
    currentIndex = index;
    emit(OnBoardingUpdateIndicator());
  }

  void skipPage() {
    currentIndex = 2;
    pageController.jumpToPage(currentIndex);
    emit(OnBoardingUpdateIndicator());
  }
}
