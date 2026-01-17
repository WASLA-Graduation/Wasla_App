part of 'auth_cubit.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthSuccessChooseFile extends AuthState {}

final class AuthTogglePass extends AuthState {}

final class AuthFocusOnTextFeild extends AuthState {}

final class AuthEnableVerifyButton extends AuthState {}

final class AuthTimer extends AuthState {}

final class AuthUpdateResidentImage extends AuthState {}

final class AuthSignUpLoading extends AuthState {}

final class AuthSignUpSuccess extends AuthState {}

final class AuthSignUpFailure extends AuthState {
  final String errMsg;

  AuthSignUpFailure({required this.errMsg});
}

final class AuthSignInLoading extends AuthState {}

final class AuthSignInSuccess extends AuthState {}

final class AuthSignInFailure extends AuthState {
  final String errMsg;

  AuthSignInFailure({required this.errMsg});
}

final class AuthVerifyEmailLoading extends AuthState {}

final class AuthVerifyEmailSuccess extends AuthState {}

final class AuthVerifyEmailFailure extends AuthState {
  final String errMsg;

  AuthVerifyEmailFailure({required this.errMsg});
}

final class AuthForgotPassCheckEmailLoading extends AuthState {}

final class AuthForgotPassCheckEmailSuccess extends AuthState {}

final class AuthForgotPassCheckEmailFailure extends AuthState {
  final String errMsg;

  AuthForgotPassCheckEmailFailure({required this.errMsg});
}

final class AuthResetPassLoading extends AuthState {}

final class AuthResetPassSuccess extends AuthState {}

final class AuthResetPassFailure extends AuthState {
  final String errMsg;

  AuthResetPassFailure({required this.errMsg});
}

final class AuthResidentCompleteInfoLoading extends AuthState {}

final class AuthResidentCompleteInfoSuccess extends AuthState {}

final class ResidentCompleteInfoFailure extends AuthState {
  final String errMsg;

  ResidentCompleteInfoFailure({required this.errMsg});
}

final class AuthDoctorCompleteInfoLoading extends AuthState {}

final class AuthDoctorCompleteInfoSuccess extends AuthState {}

final class AuthDoctorCompleteInfoFailure extends AuthState {
  final String errMsg;

  AuthDoctorCompleteInfoFailure({required this.errMsg});
}

final class AuthGetRolesSuccess extends AuthState {}

final class AuthGetRolesFailure extends AuthState {
  final String errMsg;

  AuthGetRolesFailure({required this.errMsg});
}

final class AuthGetSepcializationSuccess extends AuthState {}

final class AuthGetSepcializationFailure extends AuthState {
  final String errMsg;

  AuthGetSepcializationFailure({required this.errMsg});
}

final class AuthLogOutSuccess extends AuthState {}

final class AuthLogOutFailure extends AuthState {
  final String errMsg;

  AuthLogOutFailure({required this.errMsg});
}
