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
