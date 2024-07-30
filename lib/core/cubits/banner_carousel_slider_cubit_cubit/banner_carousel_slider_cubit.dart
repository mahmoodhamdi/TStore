import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'banner_carousel_slider_state.dart';

class BannerCarouselSliderCubit extends Cubit<BannerCarouselSliderState> {
  BannerCarouselSliderCubit() : super(BannerCarouselSliderInitial());

  int selectedIndex = 0;
  void changeIndex(int index) {
    selectedIndex = index;
    emit(BannerCarouselSliderChanged(selectedIndex: selectedIndex));
  }
}
