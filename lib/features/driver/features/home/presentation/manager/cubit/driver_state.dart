part of 'driver_cubit.dart';

sealed class DriverState {}

final class DriverInitial extends DriverState {}

final class DriverUpdateBottomNabBarIndex extends DriverState {}

final class DriverGetProfileLoading extends DriverState {}

final class DriverGetProfileSuccess extends DriverState {}

final class DriverGetProfileFailure extends DriverState {
  final String message;
  DriverGetProfileFailure({required this.message});
}

final class DriverGetDashboardDataLoading extends DriverState {}

final class DriverGetDashboardDataSuccess extends DriverState {}
final class DriverGetDashboardDataFromDropDown extends DriverState {}

final class DriverDashboardDataFailure extends DriverState {
  final String message;
  DriverDashboardDataFailure({required this.message});
}
