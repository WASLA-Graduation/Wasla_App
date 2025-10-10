part of 'auth_cubit.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}
final class AuthChangeRole extends AuthState {}
final class AuthTogglePass extends AuthState {}
final class AuthFocusOnTextFeild extends AuthState {}
final class AuthEnableVerifyButton extends AuthState {}
final class AuthTimer extends AuthState {}
