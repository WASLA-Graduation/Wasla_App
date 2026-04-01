part of 'doctor_home_cubit.dart';

sealed class DoctorHomeState {}

final class DoctorHomeInitial extends DoctorHomeState {}

final class DoctorUpdate extends DoctorHomeState {}

final class DoctorGetChartLoading extends DoctorHomeState {}

final class DoctorGetChartSuccess extends DoctorHomeState {}

final class DoctorGetBookingsLoading extends DoctorHomeState {}

final class DoctorGetBookingsSuccess extends DoctorHomeState {}

final class DoctorGetDataFailure extends DoctorHomeState {
  final String errorMessage;
  DoctorGetDataFailure({required this.errorMessage});
}

final class DoctorRemoveBookingSuccess extends DoctorHomeState {}

final class DoctorRemoveBookingLoading extends DoctorHomeState {}

final class DoctorRemoveBookingFailure extends DoctorHomeState {
  final String errorMessage;
  DoctorRemoveBookingFailure({required this.errorMessage});
}

final class DoctorUpdateBookingSuccess extends DoctorHomeState {}

final class DoctorUpdateBookingLoading extends DoctorHomeState {}

final class DoctorUpdateBookingFailure extends DoctorHomeState {
  final String errorMessage;
  DoctorUpdateBookingFailure({required this.errorMessage});
}

final class DoctorGetChartByYear extends DoctorHomeState {
  final YearDataModel yearDataModel;
  DoctorGetChartByYear({required this.yearDataModel});
}


final class GetProfileLoading extends DoctorHomeState {}

final class GetProfileSuccess extends DoctorHomeState {}

final class GetProfileFailure extends DoctorHomeState {
  final String errMsg;
  GetProfileFailure({required this.errMsg});
}