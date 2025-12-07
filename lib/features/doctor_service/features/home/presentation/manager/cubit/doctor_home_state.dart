part of 'doctor_home_cubit.dart';


sealed class DoctorHomeState {}

final class DoctorHomeInitial extends DoctorHomeState {}
final class DoctorUpdate extends DoctorHomeState {}

final class DoctorGetChartLoading extends DoctorHomeState {}

final class DoctorGetChartSuccess extends DoctorHomeState {}

final class DoctorGetDataFailure extends DoctorHomeState {
  final String errorMessage;
  DoctorGetDataFailure({required this.errorMessage});
}
