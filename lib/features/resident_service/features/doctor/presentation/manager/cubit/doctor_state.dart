part of 'doctor_cubit.dart';

sealed class DoctorState {}

final class DoctorInitial extends DoctorState {}

/// 3 basics states
final class DoctorNetworkState extends DoctorState {}

final class DoctorFailureState extends DoctorState {}

final class DoctorOnRetryState extends DoctorState {}

final class DoctorUpdateState extends DoctorState {}

final class DoctorGetSpecialityListSuccess extends DoctorState {}

final class DoctorGetSpecialityListLoading extends DoctorState {}



final class DoctorGetBySpecialityListSuccess extends DoctorState {}

final class DoctorGetBySpecialityListLoading extends DoctorState {}



final class DoctorGetServicesListSuccess extends DoctorState {}

final class DoctorGetServicesListLoading extends DoctorState {}
final class DoctortUpdatePaymentStauts extends DoctorState {}



final class DoctorBookServiceWithCashSuccess extends DoctorState {}
final class DoctorBookServiceWithCreditCardSuccess extends DoctorState {}

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

final class DoctorDeleteReviweSuccess extends DoctorState {}

final class DoctorDeleteReviweLoading extends DoctorState {}

final class DoctorDeleteReviweFailure extends DoctorState {
  final String errMsg;

  DoctorDeleteReviweFailure({required this.errMsg});
}

final class DoctorUpdateReviweSuccess extends DoctorState {}

final class DoctorUpdateReviweLoading extends DoctorState {}

final class DoctorUpdateReviweFailure extends DoctorState {
  final String errMsg;

  DoctorUpdateReviweFailure({required this.errMsg});
}
