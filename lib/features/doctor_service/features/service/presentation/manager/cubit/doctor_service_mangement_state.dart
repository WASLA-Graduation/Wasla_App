part of 'doctor_service_mangement_cubit.dart';

sealed class DoctorServiceMangementState {}

final class DoctorServiceMangementInitial extends DoctorServiceMangementState {}

final class DoctorServiceMangementUpdate extends DoctorServiceMangementState {}

final class DoctorServiceMangementGetServiceLoading
    extends DoctorServiceMangementState {}

final class DoctorServiceMangementGetServiceSuccess
    extends DoctorServiceMangementState {}

final class DoctorServiceMangementGetServiceFailure
    extends DoctorServiceMangementState {
  final String errorMessage;
  DoctorServiceMangementGetServiceFailure({required this.errorMessage});
}

final class DoctorServiceMangementDelateServiceLoading
    extends DoctorServiceMangementState {}

final class DoctorServiceMangementDelateServiceSuccess
    extends DoctorServiceMangementState {}

final class DoctorServiceMangementDelateServiceFailure
    extends DoctorServiceMangementState {
  final String errorMessage;
  DoctorServiceMangementDelateServiceFailure({required this.errorMessage});
}

final class DoctorServiceMangementAddOrUpdateServiceLoading
    extends DoctorServiceMangementState {}

final class DoctorServiceMangementAddOrUpdateServiceSuccess
    extends DoctorServiceMangementState {}

final class DoctorServiceMangementAddOrUpdateServiceFailure
    extends DoctorServiceMangementState {
  final String errorMessage;
  DoctorServiceMangementAddOrUpdateServiceFailure({required this.errorMessage});
}


