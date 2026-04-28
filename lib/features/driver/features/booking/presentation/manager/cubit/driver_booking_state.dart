part of 'driver_booking_cubit.dart';

sealed class DriverBookingState {}

final class DriverBookingInitial extends DriverBookingState {}

///basic states
///final class DriverBookingInitial extends DriverBookingState {}
final class DriverBookingNetworkState extends DriverBookingState {}

final class DriverBookingFailureState extends DriverBookingState {}

final class DriverBookingOnRetryState extends DriverBookingState {}

final class DriverGetBookingsLoading extends DriverBookingState {}

final class DriverGetBookingsSuccess extends DriverBookingState {
  final List<GeneralResidentBookingsModel> allBookings;
  DriverGetBookingsSuccess({required this.allBookings});
}
