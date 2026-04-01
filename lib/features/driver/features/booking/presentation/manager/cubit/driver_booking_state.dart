part of 'driver_booking_cubit.dart';

sealed class DriverBookingState {}

final class DriverBookingInitial extends DriverBookingState {}

final class DriverGetBookingsLoading extends DriverBookingState {}

final class DriverGetBookingsSuccess extends DriverBookingState {
  final List<GeneralResidentBookingsModel> allBookings;
  DriverGetBookingsSuccess({required this.allBookings});
}

final class DriverGetBookingsFailure extends DriverBookingState {
  final String errorMessage;
  DriverGetBookingsFailure({required this.errorMessage});
}
