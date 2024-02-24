part of 'navigation_menu_cubit.dart';

sealed class NavigationMenuState extends Equatable {
  const NavigationMenuState();

  @override
  List<Object> get props => [];
}

final class NavigationMenuInitial extends NavigationMenuState {}
final class NavigationMenuChanged extends NavigationMenuState {
  final int selectedIndex;
  const NavigationMenuChanged({required this.selectedIndex});
  @override
  List<Object> get props => [selectedIndex];
}
