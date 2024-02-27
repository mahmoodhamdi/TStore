import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'banner_carousel_slider_state.dart';

class BannerCarouselSliderCubit extends Cubit<BannerCarouselSliderState> {
  BannerCarouselSliderCubit() : super(BannerCarouselSliderInitial());

  int selectedIndex = 0;
  void changeIndex(int index) {
    selectedIndex = index;
    emit(BannerCarouselSliderChanged(selectedIndex: selectedIndex));
  }
}
