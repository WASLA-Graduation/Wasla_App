part of 'driver_trip_cubit.dart';

sealed class DriverTripState {}

final class DriverTripInitial extends DriverTripState {}

/// 3 Basic States

final class DriverTripNetworkState extends DriverTripState {}

final class DriverTripFailureState extends DriverTripState {}

final class DriverTripOnRetryState extends DriverTripState {}

final class DriverChangeMyLocation extends DriverTripState {}

final class DriverBackToMyLocation extends DriverTripState {}

final class DriverWhenArrived extends DriverTripState {}

class DriverCancelRideLoading extends DriverTripState {}

class DriverStartRideLoading extends DriverTripState {}

class DriverCancelRideSuccess extends DriverTripState {}

class DriverStrartRideSuccess extends DriverTripState {}

class DriverStartRideFailure extends DriverTripState {
  final String errorMessage;
  DriverStartRideFailure({required this.errorMessage});
}

class DriverCancelRideFailure extends DriverTripState {
  final String errorMessage;
  DriverCancelRideFailure({required this.errorMessage});
}

class DriverCompleteRideSuccess extends DriverTripState {}

class DriverCompleteRideLoading extends DriverTripState {}

class DriverCompleteRideFailure extends DriverTripState {
  final String errorMessage;
  DriverCompleteRideFailure({required this.errorMessage});
}

class DriverAcceptRideSuccess extends DriverTripState {}

class DriverAcceptRideLoading extends DriverTripState {}

class DriverAcceptRideFailure extends DriverTripState {
  final String errorMessage;
  DriverAcceptRideFailure({required this.errorMessage});
}

//// Driver Get Ride Deatials
class DriverGetRideDeatialsSuccess extends DriverTripState {}

class DriverGetRideDeatialsLoading extends DriverTripState {}
