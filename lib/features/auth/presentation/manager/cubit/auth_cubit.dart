import 'dart:async';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/database/api/api_keys.dart';
import 'package:wasla/core/database/cache/secure_storage_helper.dart';
import 'package:wasla/core/database/cache/shared_preferences_helper.dart';
import 'package:wasla/core/enums/driver_enums.dart';
import 'package:wasla/core/functions/validate_text_form_field.dart';
import 'package:wasla/core/utils/app_strings.dart';
import 'package:wasla/core/models/doctor_specializationa_model.dart';
import 'package:wasla/features/auth/data/models/roles_model.dart';
import 'package:wasla/features/auth/data/models/sign_in_model.dart';
import 'package:wasla/features/auth/data/repo/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepo) : super(AuthInitial());

  final AuthRepo authRepo;

  final singInformKey = GlobalKey<FormState>();
  final singUpformKey = GlobalKey<FormState>();
  final forgotPassformKey = GlobalKey<FormState>();
  final resetPassformKey = GlobalKey<FormState>();
  final residentInfoformKey = GlobalKey<FormState>();
  final doctortInfoformKey = GlobalKey<FormState>();
  final doctorCompletetInfoformKey = GlobalKey<FormState>();
  final resturentInfoformKey = GlobalKey<FormState>();
  final driverInfoformKey = GlobalKey<FormState>();
  final gymInfoformKey = GlobalKey<FormState>();
  final technicantInfoformKey = GlobalKey<FormState>();
  String role = '';
  List<File> gymImages = [];
  int selectedColor = -1;

  bool isPasswordVisible = false, enableButton = false;
  String email = '', password = '', confirmPassword = '', otpCode = '';
  final TextEditingController dateController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  double lat = 0.0, lan = 0.0, graduationYear = 0.0;
  String roleId = '';
  String name = '',
      phone = '',
      experienceYears = '',
      description = '',
      nationalId = '',
      universtiyName = '',
      gymName = '',
      gymOwnerName = '',
      gymGmail = '',
      gymPhones = '',
      owner = '',
      ownerPhone = '',
      resturentName = '',
      hosptialName = '',
      vehicleModel = '',
      vehicleNumber = '';

  int technicantSpeciality = -1;
  PlatformFile? file;
  int? spacializationID;

  List<RolesModel> roles = [];
  List<DoctorSpecializationaModel> doctorSpecialization = [];

  Timer? timer;
  int remainingSeconds = 60;
  File? residentImage, resturentImage;
  SignInDataModel? dataModel;

  List<PlatformFile> driverFiles = [];
  List<PlatformFile> technicantDocuments = [];
  VehicleType vehicleType = VehicleType.car;

  void updateVehicleType({required VehicleType type}) {
    vehicleType = type;
    emit(AuthUpdate());
  }

  void updateTechnicantDocuments(List<PlatformFile> files) {
    technicantDocuments = files;
    emit(AuthUpdateTechnicantDocuments());
  }

  void updateTechnicantSpeciality({required int speciality}) {
    technicantSpeciality = speciality;
    emit(AuthUpdateTechnicantSpecialization());
  }

  void updateVehicleColor({required int color}) {
    selectedColor = color;
    emit(AuthUpdate());
  }

  void enableVerifyButton() {
    enableButton = true;
    emit(AuthEnableVerifyButton());
  }

  void uploadIImages(List<File> image) {
    gymImages = image;
    emit(AuthSuccessChooseFile());
  }

  void uploadFiles(List<PlatformFile> files) {
    driverFiles = files;
    emit(AuthSuccessChooseFile());
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
        remainingSeconds = 60;
        enableButton = false;
        forgotPassCheckEmail();
      }
    });
  }

  void updateResidentImage(File image) {
    residentImage = image;
    emit(AuthUpdateResidentImage());
  }

  Future<void> signUpWithEmailAndPassword() async {
    if (roleId.isEmpty) {
      emit(AuthSignUpFailure(errMsg: "Please Choose Role"));
      return;
    }

    emit(AuthSignUpLoading());
    final response = await authRepo.signUpWithEmailAndPassword(
      email: email,
      pass: password,
      role: roleId,
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
      hospitalName: hosptialName,
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

  Future<void> driverCompleteInfo() async {
    if (driverFiles.isEmpty) {
      emit(
        AuthDriverCompleteInfoFailure(errMsg: "Please Choose  Driver Files"),
      );
      return;
    }
    if (residentImage == null) {
      emit(AuthDriverCompleteInfoFailure(errMsg: "Please Choose Image"));
      return;
    }
    if (gymImages.isEmpty) {
      emit(
        AuthDriverCompleteInfoFailure(errMsg: "Please Choose Vehicle Images"),
      );
      return;
    }
    if (selectedColor == -1) {
      emit(
        AuthDriverCompleteInfoFailure(errMsg: "Please Choose Vehicle Color"),
      );
      return;
    }
    emit(AuthDriverCompleteInfoLoading());
    final response = await authRepo.driverCompleteInfo(
      vehicleColor: selectedColor,
      email: email,
      fullName: name,
      phone: phone,
      bDate: dateController.text,
      description: description,
      photo: residentImage!,
      lat: lat,
      lng: lan,
      drivingExperienceYears: int.parse(experienceYears),
      vehicleType: vehicleType.index,
      vehicleModel: vehicleModel,
      vehicleNumber: vehicleNumber,
      vehicleImages: gymImages,
      driverFiles: driverFiles,
    );
    response.fold(
      (error) {
        emit(AuthDriverCompleteInfoFailure(errMsg: error));
      },
      (success) {
        emit(AuthDriverCompleteInfoSuccess());
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

  Future<void> logOut() async {
    final reponse = await authRepo.logOut();
    reponse.fold(
      (e) {
        emit(AuthLogOutFailure(errMsg: e));
      },
      (success) {
        emit(AuthLogOutSuccess());
      },
    );
  }

  Future<void> gymCompleteInfo() async {
    if (gymImages.isEmpty) {
      emit(
        AuthGymCompleteInfoFailure(errMsg: "Please Choose At Least One Image"),
      );
      return;
    }
    emit(AuthGymCompleteInfoLoading());
    final response = await authRepo.gymCompleteInfo(
      gmail: email,
      businessName: gymName,
      ownerName: gymName,
      description: description,
      phones: extractEgyptPhones(gymPhones)!,
      latitude: lat,
      longitude: lan,
      photos: gymImages,
    );

    response.fold(
      (error) {
        emit(AuthGymCompleteInfoFailure(errMsg: error));
      },
      (success) {
        gymImages.clear();
        emit(AuthGymCompleteInfoSuccess());
      },
    );
  }

  Future<void> technicantCompleteInfo() async {
    if (technicantSpeciality == -1) {
      emit(
        TechnicantCompleteInfoFailure(errMsg: "Please Choose Specialization"),
      );
      return;
    }

    if (residentImage == null) {
      emit(TechnicantCompleteInfoFailure(errMsg: "Please Choose Image"));
      return;
    }
    if (technicantDocuments.isEmpty) {
      emit(
        TechnicantCompleteInfoFailure(
          errMsg: "Please Choose At Least One Document",
        ),
      );
      return;
    }
    emit(AuthTechnicantCompleteInfoLoading());
    final response = await authRepo.technicantCompleteInfo(
      email: email,
      fullName: name,
      phone: phone,
      bDate: dateController.text,
      description: description,
      lat: lat,
      lng: lan,
      experienceYears: int.parse(experienceYears),
      specialty: technicantSpeciality,
      technicantDocuments: technicantDocuments,
      photo: residentImage!,
    );
    response.fold(
      (error) {
        emit(TechnicantCompleteInfoFailure(errMsg: error));
      },
      (success) {
        resetData();
        emit(AuthTechnicantCompleteInfoSuccess());
      },
    );
  }

  void saveSignInData() async {
    SecureStorageHelper.set(key: ApiKeys.token, value: dataModel!.token);
    // SecureStorageHelper.set(
    //   key: ApiKeys.refreshToken,
    //   value: dataModel!.refreshToken,
    // );
    await SecureStorageHelper.set(
      key: ApiKeys.userId,
      value: dataModel!.userId,
    );
    await SharedPreferencesHelper.set(
      key: ApiKeys.role,
      value: dataModel!.role.name,
    );

    await SharedPreferencesHelper.set(key: AppStrings.isSingedIn, value: true);
  }

  void resetData() {
    role = '';
    roleId = '';
    email = '';
    password = '';
    confirmPassword = '';
    otpCode = '';
    name = '';
    phone = '';
    experienceYears = '';
    description = '';
    nationalId = '';
    universtiyName = '';
    gymName = '';
    gymOwnerName = '';
    gymGmail = '';
    gymPhones = '';
    owner = '';
    ownerPhone = '';
    resturentName = '';
    hosptialName = '';
    vehicleModel = '';
    vehicleNumber = '';

    selectedColor = -1;
    technicantSpeciality = -1;
    lat = 0.0;
    lan = 0.0;
    graduationYear = 0.0;
    spacializationID = null;

    isPasswordVisible = false;
    enableButton = false;

    dateController.clear();
    addressController.clear();

    file = null;
    residentImage = null;
    resturentImage = null;

    gymImages.clear();
    roles.clear();
    doctorSpecialization.clear();
    driverFiles.clear();
    technicantDocuments.clear();

    timer?.cancel();
    timer = null;
    remainingSeconds = 60;

    dataModel = null;

    vehicleType = VehicleType.car;
  }

  @override
  Future<void> close() {
    dateController.dispose();
    addressController.dispose();
    return super.close();
  }
}
