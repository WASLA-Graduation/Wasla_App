part of 'gym_dashboard_cubit.dart';

sealed class GymDashboardState {}

final class GymDashboardInitial extends GymDashboardState {}

final class GymDashboardUpdateState extends GymDashboardState {}

final class GymDashboardProfileGetProfileLoading extends GymDashboardState {}

final class GymDashboardProfileGetProfileSuccess extends GymDashboardState {}

final class GymDashboardProfileGetProfileFailure extends GymDashboardState {
  final String errMsg;
  GymDashboardProfileGetProfileFailure({required this.errMsg});
}

final class GymDashboardProfileGetChartLoading extends GymDashboardState {}

final class GymDashboardProfileGetChartSuccess extends GymDashboardState {}

final class GymDashboardProfileGetChartFailure extends GymDashboardState {
  final String errMsg;
  GymDashboardProfileGetChartFailure({required this.errMsg});
}

final class GymDashboardProfileGetBookingsListLoading
    extends GymDashboardState {}

final class GymDashboardProfileGetBookingsListSuccess
    extends GymDashboardState {}

final class GymDashboardProfileGetBookingsListFailure
    extends GymDashboardState {
  final String errMsg;
  GymDashboardProfileGetBookingsListFailure({required this.errMsg});
}
