part of 'gym_resident_cubit.dart';

sealed class GymResidentState {}

final class GymResidentInitial extends GymResidentState {}

//// 3 basic states
final class GymResidentNetworkState extends GymResidentState {}

final class GymResidentFailureState extends GymResidentState {}

final class GymResidentOnRetryState extends GymResidentState {}

final class GymResidentGetAllGymsLoading extends GymResidentState {}

final class GymResidentGetAllGymsSuccess extends GymResidentState {}

final class GymResidentGetAllGymsFromPaginationLoading
    extends GymResidentState {}

final class GymResidentGetAllGymsFromPaginationSuccess
    extends GymResidentState {}

final class GymResidentGetGymDetailsSuccess extends GymResidentState {}

final class GymResidentGetGymPackagesLoading extends GymResidentState {}

final class GymResidentGetGymPackagesSuccess extends GymResidentState {}

/////book with gym states
abstract class GymResidentBookingState extends GymResidentState {
  final int itemId;
  GymResidentBookingState({required this.itemId});
}

final class GymResidentBookingLoading extends GymResidentBookingState {
  GymResidentBookingLoading({required super.itemId});
}

final class GymResidentBookingSuccess extends GymResidentBookingState {
  final int bookingId;

  GymResidentBookingSuccess({required this.bookingId, required super.itemId});
}
final class GymResidentBookingSuccessFromCash extends GymResidentBookingState {
  final int bookingId;

  GymResidentBookingSuccessFromCash({required this.bookingId, required super.itemId});
}

final class GymResidentBookingFailure extends GymResidentBookingState {
  final String errMsg;

  GymResidentBookingFailure({required this.errMsg, required super.itemId});
}
