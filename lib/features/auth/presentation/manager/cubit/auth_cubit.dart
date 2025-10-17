import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/enums/service_role.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  ServiceRole role = ServiceRole.resident;
  final singInformKey = GlobalKey<FormState>();
  final singUpformKey = GlobalKey<FormState>();
  final forgotPassformKey = GlobalKey<FormState>();
  final resetPassformKey = GlobalKey<FormState>();
  final residentInfoformKey = GlobalKey<FormState>();

  bool isPasswordVisible = false, enableButton = false;
  String email = '', password = '', confirmPassword = '', otpCode = '';
  final TextEditingController residentDateController = TextEditingController();
  final TextEditingController residentAddressController =
      TextEditingController();
  String lat = '0', lan = '0';

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
}
