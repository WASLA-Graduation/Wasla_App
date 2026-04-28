part of 'driver_cubit.dart';

sealed class DriverState {}

final class DriverInitial extends DriverState {}

///basic states
final class DriverNetworkState extends DriverState {}

final class DriverFailureState extends DriverState {}

final class DriverOnRetryState extends DriverState {}

final class DriverUpdateBottomNabBarIndex extends DriverState {}

final class DriverGetProfileSuccess extends DriverState {
  final DriverProfileModel driver;

  DriverGetProfileSuccess({required this.driver});
}

final class DriverGetDashboardDataLoading extends DriverState {}

final class DriverGetDashboardDataSuccess extends DriverState {}

final class DriverGetDashboardDataFromDropDown extends DriverState {}
