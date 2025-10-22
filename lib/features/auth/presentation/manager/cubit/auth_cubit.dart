import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/enums/service_role.dart';
import 'package:wasla/features/auth/data/repo/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepo) : super(AuthInitial());

  final AuthRepo authRepo;

  ServiceRole role = ServiceRole.resident;
  final singInformKey = GlobalKey<FormState>();
  final singUpformKey = GlobalKey<FormState>();
  final forgotPassformKey = GlobalKey<FormState>();
  final resetPassformKey = GlobalKey<FormState>();
  final residentInfoformKey = GlobalKey<FormState>();

  bool isPasswordVisible = false, enableButton = false;
  String email = '', password = '', confirmPassword = '', otpCode = '';
  final TextEditingController dateController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  String lat = '0', lan = '0';
  String name = '', phone = '', nakeName = '';

  Timer? timer;
  int remainingSeconds = 60;
  File? residentImage;

  void enableVerifyButton() {
    enableButton = true;
    emit(AuthEnableVerifyButton());
  }

  void changeRole(ServiceRole role) {
    this.role = role;
    emit(AuthChangeRole());
  }

  void togglePassIcon() {
    isPasswordVisible = !isPasswordVisible;
    emit(AuthTogglePass());
  }

  void resendCodeTimer() {
    remainingSeconds = 60;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds > 0) {
        remainingSeconds--;
        emit(AuthTimer());
      } else {
        timer.cancel();

        ///handle your logic
      }
    });
  }

  void updateResidentImage(File image) {
    residentImage = image;
    emit(AuthUpdateResidentImage());
  }

  Future<void> signUpWithEmailAndPassword() async {
    emit(AuthSignUpLoading());
    final response = await authRepo.signUpWithEmailAndPassword(
      email: email,
      pass: password,
      // role: role.name,
      role: "Doctor",
    );
    response.fold(
      (error) {
        emit(AuthSignUpFailure(errMsg: error));
      },
      (success) {
        emit(AuthSignUpSuccess());
      },
    );
  }

  Future<void> verifyEmail() async {
    emit(AuthVerifyEmailLoading());
    final response = await authRepo.verifyEmail(
      email: email,
      verificationCode: otpCode,
    );
    response.fold(
      (error) {
        emit(AuthVerifyEmailFailure(errMsg: error));
      },
      (success) {
        emit(AuthVerifyEmailSuccess());
      },
    );
  }

  Future<void> forgotPassCheckEmail() async {
    emit(AuthForgotPassCheckEmailLoading());
    final response = await authRepo.forgotPassCheckEmail(email: email);
    response.fold(
      (error) {
        emit(AuthForgotPassCheckEmailFailure(errMsg: error));
      },
      (success) {
        emit(AuthForgotPassCheckEmailSuccess());
      },
    );
  }

  Future<void> resetPassword() async {
    if (password != confirmPassword) {
      emit(AuthResetPassFailure(errMsg: "Password Not Match"));
      return;
    }
    emit(AuthResetPassLoading());
    final response = await authRepo.resetPassword(
      email: email,
      newPassword: password,
    );
    response.fold(
      (error) {
        emit(AuthResetPassFailure(errMsg: error));
      },
      (success) {
        emit(AuthResetPassSuccess());
      },
    );
  }
}
