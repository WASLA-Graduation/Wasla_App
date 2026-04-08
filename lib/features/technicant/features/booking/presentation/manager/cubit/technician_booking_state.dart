part of 'technician_booking_cubit.dart';

sealed class TechnicianBookingState {}

class TechincainBookingInitialState extends TechnicianBookingState {}

class TechincainBookingNetworkState extends TechnicianBookingState {}

class TechincainBookingOnRetryState extends TechnicianBookingState {}

class TechincainBookingFailureState extends TechnicianBookingState {}

class TechincainBookingUpdateCurrentTapState extends TechnicianBookingState {}

/////GetAllBookings
class TechincainGetBookingsLoadingState extends TechnicianBookingState {}

class TechincainGetBookingsLoadedState extends TechnicianBookingState {
  final List<TechnicainBookingModel> bookings;
  TechincainGetBookingsLoadedState({required this.bookings});
}

////AcceptBooking

class TechincainAcceptBookingSuccessState extends TechnicianBookingState {
  final int bookingId;

  TechincainAcceptBookingSuccessState({required this.bookingId});
}

class TechincainAcceptBookingFailureState extends TechnicianBookingState {
  final String errorMessage;
  final int bookingId;

  TechincainAcceptBookingFailureState({
    required this.errorMessage,
    required this.bookingId,
  });
}

////CancelBooking

class TechincainCancelBookingSuccessState extends TechnicianBookingState {
  final int bookingId;

  TechincainCancelBookingSuccessState({required this.bookingId});
}

class TechincainCancelBookingFailureState extends TechnicianBookingState {
  final int bookingId;
  final String errorMessage;

  TechincainCancelBookingFailureState({
    required this.bookingId,
    required this.errorMessage,
  });
}


