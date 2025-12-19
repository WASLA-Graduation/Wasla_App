part of 'doctor_cubit.dart';

sealed class DoctorState {}

final class DoctorInitial extends DoctorState {}

final class DoctorUpdateState extends DoctorState {}

final class DoctorGetSpecialityListSuccess extends DoctorState {}

final class DoctorGetSpecialityListLoading extends DoctorState {}

final class DoctorGetSpecialityListFailure extends DoctorState {
  final String errMsg;

  DoctorGetSpecialityListFailure({required this.errMsg});
}

final class DoctorGetBySpecialityListSuccess extends DoctorState {}

final class DoctorGetBySpecialityListLoading extends DoctorState {}

final class DoctorGetBySpecialityListFailure extends DoctorState {
  final String errMsg;

  DoctorGetBySpecialityListFailure({required this.errMsg});
}

final class DoctorGetServicesListSuccess extends DoctorState {}

final class DoctorGetServicesListLoading extends DoctorState {}

final class DoctorGetServicesListFailure extends DoctorState {
  final String errMsg;

  DoctorGetServicesListFailure({required this.errMsg});
}

final class DoctorBookServiceSuccess extends DoctorState {}

final class DoctorBookServiceLoading extends DoctorState {}

final class DoctorBookServiceFailure extends DoctorState {
  final String errMsg;

  DoctorBookServiceFailure({required this.errMsg});
}

final class DoctorGetReviwesSuccess extends DoctorState {}

final class DoctorGetReviwesLoading extends DoctorState {}

final class DoctorGetReviwesFailure extends DoctorState {
  final String errMsg;

  DoctorGetReviwesFailure({required this.errMsg});
}
final class DoctorAddReviweSuccess extends DoctorState {}

final class DoctorAddReviweLoading extends DoctorState {}

final class DoctorAddReviweFailure extends DoctorState {
  final String errMsg;

  DoctorAddReviweFailure({required this.errMsg});
}
