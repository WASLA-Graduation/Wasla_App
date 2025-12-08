part of 'resident_booking_cubit.dart';

sealed class ResidentBookingState {}

final class ResidentBookingInitial extends ResidentBookingState {}

final class ResidentBookingUpdate extends ResidentBookingState {}

final class ResidentGetBookingSuccess extends ResidentBookingState {
  final List<ResidentBookingModel> bookings;

  ResidentGetBookingSuccess({required this.bookings});
}

final class ResidentGetBookingLoading extends ResidentBookingState {}

final class ResidentGetBookingFailure extends ResidentBookingState {
  final String errMsg;

  ResidentGetBookingFailure({required this.errMsg});
}
final class ResidentCancelBookingSuccess extends ResidentBookingState {

}

final class ResidentCancelBookingLoading extends ResidentBookingState {}

final class ResidentCacelBookingFailure extends ResidentBookingState {
  final String errMsg;

  ResidentCacelBookingFailure({required this.errMsg});
}
