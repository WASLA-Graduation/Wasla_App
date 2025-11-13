part of 'doctor_cubit.dart';

sealed class DoctorState {}

final class DoctorInitial extends DoctorState {}

final class DoctorGetSpecialityListSuccess extends DoctorState {}

final class DoctorGetSpecialityListLoading extends DoctorState {}

final class DoctorGetSpecialityListFailure extends DoctorState {
  final String errMsg;

  DoctorGetSpecialityListFailure({required this.errMsg});
}
