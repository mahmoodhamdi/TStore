// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:t_store/features/shop/presentation/views/home/home_view.dart';
import 'package:t_store/features/personalization/presentation/views/profile_view.dart';
import 'package:t_store/features/shop/presentation/views/store/store_view.dart';
import 'package:t_store/features/shop/presentation/views/wishlist_view.dart';

part 'navigation_menu_state.dart';

class NavigationMenuCubit extends Cubit<NavigationMenuState> {
  NavigationMenuCubit() : super(NavigationMenuInitial());
  int selectedIndex = 0;

  final screensList = [
    const HomeView(),
    const StoreView(),
    const WishlistView(),
    const ProfileView(),
  ];
  void changeIndex(int index) {
    selectedIndex = index;
    emit(NavigationMenuChanged(
      selectedIndex: selectedIndex,
    ));

  }
  Widget getScreen() {
    return screensList[selectedIndex];
  }
}
