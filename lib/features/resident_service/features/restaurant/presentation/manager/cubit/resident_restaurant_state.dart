part of 'resident_restaurant_cubit.dart';

sealed class ResidentRestaurantState {
  const ResidentRestaurantState();
}

final class ResidentRestaurantInitial extends ResidentRestaurantState {}

///Basics States
final class ResidentRestaurantNetworkState extends ResidentRestaurantState {}

final class ResidentRestaurantOnRetryState extends ResidentRestaurantState {}

final class ResidentRestaurantFailureState extends ResidentRestaurantState {}

///Get Restaurant Categories
final class GetRestaurantCategoriesLoadingState
    extends ResidentRestaurantState {}

final class GetRestaurantCategoriesLoadedState extends ResidentRestaurantState {
  final List<RestaurantCatergoriesModel> categories;

  GetRestaurantCategoriesLoadedState({required this.categories});
}

///Get Restaurants By Category
final class GetRestaurantsByCategorieLoadingState
    extends ResidentRestaurantState {}

final class GetRestaurantsByCategorieFromPaginationLoadingState
    extends ResidentRestaurantState {}

final class GetRestaurantsByCategoryLoadedState
    extends ResidentRestaurantState {
  final List<RestaurantModel> restaurants;

  GetRestaurantsByCategoryLoadedState({required this.restaurants});
}

///select category
final class ResidentRestaurantSelectCategoryState extends ResidentRestaurantState {}


