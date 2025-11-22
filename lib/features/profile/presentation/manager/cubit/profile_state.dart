part of 'profile_cubit.dart';

sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileUpdate extends ProfileState {}

final class ProfileGetProfileLoading extends ProfileState {}

final class ProfileGetProfileSuccess extends ProfileState {}

final class ProfileGetProfileFailure extends ProfileState {
  final String errMsg;
  ProfileGetProfileFailure({required this.errMsg});
}

final class ProfileChangePassLoading extends ProfileState {}

final class ProfileChangePassSuccess extends ProfileState {}

final class ProfileChangePassFailure extends ProfileState {
  final String errMsg;
  ProfileChangePassFailure({required this.errMsg});
}

final class ProfileResidentUpdateInfoLoading extends ProfileState {}

final class ProfileResidentUpdateInfoSuccess extends ProfileState {}

final class ProfileResidentUpdateInfoFailure extends ProfileState {
  final String errMsg;
  ProfileResidentUpdateInfoFailure({required this.errMsg});
}
