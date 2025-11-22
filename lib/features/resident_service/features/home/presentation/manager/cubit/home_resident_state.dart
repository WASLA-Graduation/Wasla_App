part of 'home_resident_cubit.dart';

sealed class HomeResidentState {}

final class HomeResidentInitial extends HomeResidentState {}

final class HomeResidentUpadateCurrentIndex extends HomeResidentState {}

final class HomeResidentGetProfileLoading extends HomeResidentState {}

final class HomeResidentGetProfileSuccess extends HomeResidentState {}

final class HomeResidentGetProfileFailure extends HomeResidentState {
  final String errMsg;
  HomeResidentGetProfileFailure({required this.errMsg});
}
