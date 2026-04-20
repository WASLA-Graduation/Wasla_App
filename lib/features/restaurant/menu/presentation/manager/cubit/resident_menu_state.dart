part of 'resident_menu_cubit.dart';

sealed class ResidentMenuState {
  const ResidentMenuState();
}

final class ResidentMenuInitial extends ResidentMenuState {}


////Update States
final class ResidentMenuSelectCategory extends ResidentMenuState {}

///Basics State
final class ResidentMenuNetworkState extends ResidentMenuState {}

final class ResidentMenuFailureState extends ResidentMenuState {}

final class ResidentMenuOnRetryState extends ResidentMenuState {}

////get menu categories

final class ResidentGetMenuCateroriesLoadingState extends ResidentMenuState {}

final class ResidentGetMenuCateroriesLoadedState extends ResidentMenuState {
  final List<RestaurantMenuCategoryModel> categories;

  const ResidentGetMenuCateroriesLoadedState(this.categories);
}

////get menu category items

final class ResidentGetMenuCategoryItemsLoadingState
    extends ResidentMenuState {}

final class ResidentGetMenuCategoryItemsLoadedState extends ResidentMenuState {
  final List<MenuItem> items;

  const ResidentGetMenuCategoryItemsLoadedState(this.items);
}
