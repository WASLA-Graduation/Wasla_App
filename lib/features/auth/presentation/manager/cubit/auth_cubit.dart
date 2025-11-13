import 'dart:async';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/database/api/api_keys.dart';
import 'package:wasla/core/database/cache/secure_storage_helper.dart';
import 'package:wasla/core/database/cache/shared_preferences_helper.dart';
import 'package:wasla/core/utils/app_strings.dart';
import 'package:wasla/features/auth/data/models/doctor_specializationa_model.dart';
import 'package:wasla/features/auth/data/models/roles_model.dart';
import 'package:wasla/features/auth/data/models/sign_in_model.dart';
import 'package:wasla/features/auth/data/repo/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepo) : super(AuthInitial());

  final AuthRepo authRepo;

  String role = '';
  final singInformKey = GlobalKey<FormState>();
  final singUpformKey = GlobalKey<FormState>();
  final forgotPassformKey = GlobalKey<FormState>();
  final resetPassformKey = GlobalKey<FormState>();
  final residentInfoformKey = GlobalKey<FormState>();
  final doctortInfoformKey = GlobalKey<FormState>();
  final doctorCompletetInfoformKey = GlobalKey<FormState>();
  final resturentInfoformKey = GlobalKey<FormState>();

  bool isPasswordVisible = false, enableButton = false;
  String email = '', password = '', confirmPassword = '', otpCode = '';
  final TextEditingController dateController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  double lat = 0.0, lan = 0.0, graduationYear = 0.0;
  String name = '',
      phone = '',
      experienceYears = '',
      description = '',
      nationalId = '',
      universtiyName = '',owner='',resturentName='';
  PlatformFile? file;
  int? spacializationID;

  List<RolesModel> roles = [];
  List<DoctorSpecializationaModel> doctorSpecialization = [];

  Timer? timer;
  int remainingSeconds = 60;
  File? residentImage,resturentImage;
  late final SignInDataModel dataModel;

  void enableVerifyButton() {
    enableButton = true;
    emit(AuthEnableVerifyButton());
  }

  void updateFile(PlatformFile f) {
    file = f;
    emit(AuthSuccessChooseFile());
  }
  void updateImage(File f) {
    resturentImage = f;
    emit(AuthSuccessChooseFile());
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
    if (role.isEmpty) {
      emit(AuthSignUpFailure(errMsg: "Please Choose Role"));
      return;
    }

    emit(AuthSignUpLoading());
    final response = await authRepo.signUpWithEmailAndPassword(
      email: email,
      pass: password,
      role: role,
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

  Future<void> doctorCompleteInfo() async {
    if (spacializationID == null) {
      emit(
        AuthDoctorCompleteInfoFailure(errMsg: "Please Choose Specialization"),
      );
      return;
    } else if (file == null) {
      emit(AuthDoctorCompleteInfoFailure(errMsg: "Please Choose CV"));
      return;
    } else if (residentImage == null) {
      emit(AuthDoctorCompleteInfoFailure(errMsg: "Please Choose Image"));
      return;
    }
    emit(AuthDoctorCompleteInfoLoading());
    final response = await authRepo.doctorCompleteInfo(
      email: email,
      fullName: name,
      phone: phone,
      bDate: dateController.text,
      universtiyName: universtiyName,
      description: description,
      image: residentImage!,
      lat: lat,
      lng: lan,
      graduationYear: graduationYear,
      spacializationID: spacializationID!,
      experienceYears: int.parse(experienceYears),
      cv: file!,
    );
    response.fold(
      (error) {
        emit(AuthDoctorCompleteInfoFailure(errMsg: error));
      },
      (success) {
        emit(AuthDoctorCompleteInfoSuccess());
      },
    );
  }

  Future<void> residentCompleteInfo() async {
    if (residentImage == null) {
      emit(ResidentCompleteInfoFailure(errMsg: "Please Choose Image"));
      return;
    }

    emit(AuthResidentCompleteInfoLoading());
    final response = await authRepo.residentCompleteInfo(
      email: email,
      fullName: name,
      nationalId: nationalId,
      phone: phone,
      bDate: dateController.text,
      image: residentImage!,
      lat: lat,
      lng: lan,
    );
    response.fold(
      (error) {
        emit(ResidentCompleteInfoFailure(errMsg: error));
      },
      (success) {
        spacializationID = null;
        emit(AuthResidentCompleteInfoSuccess());
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

  Future<void> signInWithEmailAndPassword() async {
    emit(AuthSignInLoading());
    final response = await authRepo.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    response.fold(
      (error) {
        emit(AuthSignInFailure(errMsg: error));
      },
      (success) {
        dataModel = success;
        _saveSignInData(dataModel);
        emit(AuthSignInSuccess());
      },
    );
  }

  Future<void> getRoles() async {
    roles.clear();
    final response = await authRepo.getRoles();
    response.fold(
      (error) {
        emit(AuthGetRolesFailure(errMsg: error));
      },
      (success) {
        roles = success;
        emit(AuthGetRolesSuccess());
      },
    );
  }

  Future<void> getDoctorSpecialization() async {
    doctorSpecialization.clear();
    final response = await authRepo.getSpecialization();
    response.fold(
      (error) {
        emit(AuthGetSepcializationFailure(errMsg: error));
      },
      (success) {
        doctorSpecialization = success;
        emit(AuthGetSepcializationSuccess());
      },
    );
  }

  void _saveSignInData(SignInDataModel dataModel) async {
    SecureStorageHelper.set(key: ApiKeys.token, value: dataModel.token);
    SecureStorageHelper.set(
      key: ApiKeys.refreshToken,
      value: dataModel.refreshToken,
    );
    SecureStorageHelper.set(key: ApiKeys.userId, value: dataModel.userId);
    SharedPreferencesHelper.set(key: ApiKeys.role, value: dataModel.role.name);
    await SharedPreferencesHelper.set(key: AppStrings.isSingedIn, value: true);
  }
}
