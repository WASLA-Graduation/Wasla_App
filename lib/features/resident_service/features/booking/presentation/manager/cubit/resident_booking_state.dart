part of 'resident_booking_cubit.dart';

sealed class ResidentBookingState {}

final class ResidentBookingInitial extends ResidentBookingState {}

//// Basic States
final class ResidentGetBookingsFailure extends ResidentBookingState {}

final class ResidentBookingNetwrok extends ResidentBookingState {}

final class ResidentBookingOnRetry extends ResidentBookingState {}
////////

final class ResidentChangeBookingTaps extends ResidentBookingState {}

final class ResidentAllGetBookingSuccess extends ResidentBookingState {}

final class ResidentGetBookingLoading extends ResidentBookingState {}

final class ResidentCancelBookingSuccess extends ResidentBookingState {
  final int bookingId;

  ResidentCancelBookingSuccess({required this.bookingId});
}

final class ResidentCancelBookingFailure extends ResidentBookingState {
  final String errMsg;
  final int bookingId;

  ResidentCancelBookingFailure({required this.bookingId, required this.errMsg});
}
