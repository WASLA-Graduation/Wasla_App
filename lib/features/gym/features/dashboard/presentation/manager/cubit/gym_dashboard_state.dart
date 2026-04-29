part of 'gym_dashboard_cubit.dart';

sealed class GymDashboardState {}

final class GymDashboardInitial extends GymDashboardState {}


/// 3 basic states
final class GymDashboardNetwrorkState extends GymDashboardState {}
final class GymDashboardFailureState extends GymDashboardState {}
final class GymDashboardOnRetryState extends GymDashboardState {}

final class GymDashboardUpdateState extends GymDashboardState {}

final class GymDashboardProfileGetProfileLoading extends GymDashboardState {}

final class GymDashboardProfileGetProfileSuccess extends GymDashboardState {}



final class GymDashboardProfileGetChartLoading extends GymDashboardState {}

final class GymDashboardProfileGetChartSuccess extends GymDashboardState {}



final class GymDashboardProfileGetBookingsListLoading
    extends GymDashboardState {}

final class GymDashboardProfileGetBookingsListSuccess
    extends GymDashboardState {}


final class GymDashboardCancelBookingLoading
    extends GymDashboardState {}

final class GymDashboardCancelBookingSuccess
    extends GymDashboardState {}

final class GymDashboardCancelBookingFailure
    extends GymDashboardState {
  final String errMsg;
  GymDashboardCancelBookingFailure({required this.errMsg});
}
