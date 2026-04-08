part of 'technician_booking_cubit.dart';

class TechnicianBookingState {
  ///todo add the type of date will retured from the api
  final BoxState<void> getBookingsState;

  TechnicianBookingState({required this.getBookingsState});

  TechnicianBookingState.initial() : getBookingsState = BoxState.initial();

  ////todo don't forget to add copy with method
}
