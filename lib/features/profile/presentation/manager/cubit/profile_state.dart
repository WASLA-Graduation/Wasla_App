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

final class ProfileUpdateInfoLoading extends ProfileState {}

final class ProfileUpdateInfoSuccess extends ProfileState {}

final class ProfileUpdateInfoFailure extends ProfileState {
  final String errMsg;
  ProfileUpdateInfoFailure({required this.errMsg});
}
final class ProfileGetDocSpecializationLoading extends ProfileState {}

final class ProfileGetDocSpecializationSuccess extends ProfileState {}

final class ProfileGetDocSpecializationFailure extends ProfileState {
  final String errMsg;
  ProfileGetDocSpecializationFailure({required this.errMsg});
}
