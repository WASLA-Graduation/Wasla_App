part of 'restaurant_dashboard_cubit.dart';

sealed class RestaurantDashboardState {
  const RestaurantDashboardState();
}

final class RestaurantDashboardInitial extends RestaurantDashboardState {}

//// Basics States
final class RestaurantDashboardFailureState extends RestaurantDashboardState {}

final class RestaurantDashboardNetworkState extends RestaurantDashboardState {}

final class RestaurantDashboardOnRetryState extends RestaurantDashboardState {}

///update bottom nav bar index state
final class RestaurantDashboardUpdateBottomNavBarIndex
    extends RestaurantDashboardState {}

///get restaurant data states

final class RestaurantDashboardGetDataSuccessState
    extends RestaurantDashboardState {
  final RestaurantModel restaurant;

  RestaurantDashboardGetDataSuccessState({required this.restaurant});
}
