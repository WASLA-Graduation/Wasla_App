part of 'technician_booking_cubit.dart';

sealed class TechnicianBookingState {}

class TechincainBookingInitialState extends TechnicianBookingState {}
class TechincainBookingNetworkState extends TechnicianBookingState {}
class TechincainBookingOnRetryState extends TechnicianBookingState {}
class TechincainBookingFailureState extends TechnicianBookingState {}
class TechincainBookingUpdateCurrentTapState extends TechnicianBookingState {}
