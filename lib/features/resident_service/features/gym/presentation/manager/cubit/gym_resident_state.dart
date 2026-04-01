part of 'gym_resident_cubit.dart';

sealed class GymResidentState {}

final class GymResidentInitial extends GymResidentState {}

final class GymResidentGetAllGymsLoading extends GymResidentState {}

final class GymResidentGetAllGymsSuccess extends GymResidentState {}

final class GymResidentGetAllGymsFailure extends GymResidentState {
  final String errMsg;

  GymResidentGetAllGymsFailure({required this.errMsg});
}

final class GymResidentGetAllGymsFromPaginationLoading
    extends GymResidentState {}

final class GymResidentGetAllGymsFromPaginationSuccess
    extends GymResidentState {}

final class GymResidentGetGymDetailsLoading extends GymResidentState {}

final class GymResidentGetGymDetailsSuccess extends GymResidentState {}

final class GymResidentGetGymDetailsFailure extends GymResidentState {
  final String errMsg;

  GymResidentGetGymDetailsFailure({required this.errMsg});
}

final class GymResidentGetGymPackagesLoading extends GymResidentState {}

final class GymResidentGetGymPackagesSuccess extends GymResidentState {}

final class GymResidentGetGymPackagesFailure extends GymResidentState {
  final String errMsg;

  GymResidentGetGymPackagesFailure({required this.errMsg});
}

final class GymResidentBookingLoading extends GymResidentState {}

final class GymResidentBookingSuccess extends GymResidentState {
  final String qrCodeUrl;

  GymResidentBookingSuccess({required this.qrCodeUrl});
}

final class GymResidentBookingFailure extends GymResidentState {
  final String errMsg;

  GymResidentBookingFailure({required this.errMsg});
}
