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

///// cancel Booking Actions

abstract class ResidentBookingActions extends ResidentBookingState {
  final int bookingId;

  ResidentBookingActions({required this.bookingId});
}

final class ResidentCancelBookingSuccess extends ResidentBookingActions {
  ResidentCancelBookingSuccess({required super.bookingId});
}

final class ResidentCancelBookingFailure extends ResidentBookingActions {
  final String errMsg;

  ResidentCancelBookingFailure({
    required super.bookingId,
    required this.errMsg,
  });
}
