import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/database/api/api_keys.dart';
import 'package:wasla/core/database/cache/secure_storage_helper.dart';
import 'package:wasla/core/enums/service_role.dart';
import 'package:wasla/core/functions/get_service_role.dart';
import 'package:wasla/core/models/user_base_model.dart';
import 'package:wasla/features/doctor_service/features/home/data/models/doctor_model.dart';
import 'package:wasla/features/profile/data/repo/profile_repo.dart';
part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.profileRepo) : super(ProfileInitial());
  final ProfileRepo profileRepo;

  PlatformFile? file;

  String fullName = '',
      phoneNumber = '',
      newPassword = '',
      currentPassword = '',
      hospitalName = '',
      universityName = '';

  int experienceYears = 0, specializationId = 0;
  double lat = 0, lng = 0;
  bool isPasswordVisible = false;
  UserBaseModel? user;

  final residentFormKey = GlobalKey<FormState>();
  final changePassFormKey = GlobalKey<FormState>();
  File? image;

  void toggglePassIcon() {
    isPasswordVisible = !isPasswordVisible;
    emit(ProfileUpdate());
  }

  void updateFile(PlatformFile f) {
    file = f;
    emit(ProfileUpdate());
  }

  Future<void> getUserProfile() async {
    emit(ProfileGetProfileLoading());
    final String? userId = await SecureStorageHelper.get(key: ApiKeys.userId);

    final response = await _getRightProfileAccordingToRole(userId: userId!);
    response.fold(
      (error) {
        emit(ProfileGetProfileFailure(errMsg: error));
      },
      (success) {
        user = success;
        emit(ProfileGetProfileSuccess());
      },
    );
  }

  Future<void> changePassword() async {
    emit(ProfileChangePassLoading());

    if (currentPassword == newPassword) {
      emit(ProfileChangePassFailure(errMsg: "You can't use the same password"));
      return;
    }

    final response = await profileRepo.changePassword(
      email: user!.emailBase,
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
    response.fold(
      (error) {
        emit(ProfileChangePassFailure(errMsg: error));
      },
      (success) {
        emit(ProfileChangePassSuccess());
      },
    );
  }

  Future<void> updateUsertInfo() async {
    emit(ProfileUpdateInfoLoading());
    final String? userId = await SecureStorageHelper.get(key: ApiKeys.userId);
    final response = await _chooseRightUpdateProfileAccordingToRole(
      userId: userId!,
    );

    response.fold(
      (error) {
        emit(ProfileUpdateInfoFailure(errMsg: error));
      },
      (success) async {
        await getUserProfile();
        _resetsVariables();
        emit(ProfileUpdateInfoSuccess());
      },
    );
  }

  void _resetsVariables() {
    image = null;
    lat = 0;
    lat = 0;
    fullName = '';
    phoneNumber = '';
    newPassword = '';
    currentPassword = '';
    hospitalName = '';
    universityName = '';
    experienceYears = 0;
    specializationId = 0;
    file = null;
  }

  _getRightProfileAccordingToRole({required String userId}) async {
    switch (getServiceRole()) {
      case ServiceRole.resident:
        return await profileRepo.getResidentProfile(userId: userId);
      case ServiceRole.driver:
        // TODO: Handle this case.
        throw UnimplementedError();
      case ServiceRole.doctor:
        return await profileRepo.getDoctorProfile(userId: userId);
      case ServiceRole.technician:
        // TODO: Handle this case.
        throw UnimplementedError();
      case ServiceRole.restaurantOwner:
        // TODO: Handle this case.
        throw UnimplementedError();
      case ServiceRole.gymOwner:
        return await profileRepo.geGymProfile(gymId: userId);
    }
  }

  _chooseRightUpdateProfileAccordingToRole({required String userId}) async {
    switch (getServiceRole()) {
      case ServiceRole.resident:
        return await profileRepo.updateResidentInfo(
          fullName: fullName.isEmpty ? user!.fullNameBase : fullName,
          phone: phoneNumber.isEmpty ? user!.phoneNumberBase : phoneNumber,
          lat: lat == 0 ? user!.latBase : lat,
          lng: lng == 0 ? user!.lngBase : lng,
          image: image,
          userId: userId,
        );
      case ServiceRole.driver:
        // TODO: Handle this case.
        throw UnimplementedError();
      case ServiceRole.doctor:
        final doctor = user as DoctorModel;
        return await profileRepo.updateDoctorInfo(
          fullName: fullName.isEmpty ? doctor.fullNameBase : fullName,
          phone: phoneNumber.isEmpty ? doctor.phoneNumberBase : phoneNumber,
          lat: lat == 0 ? doctor.latitude : lat,
          lng: lng == 0 ? doctor.longitude : lng,
          profilePhoto: image,
          userId: userId,
          birthDay: doctor.birthDay,
          universityName: doctor.universityName,
          hospitalName: hospitalName.isEmpty
              ? doctor.hospitalname
              : hospitalName,
          graduationYear: doctor.graduationYear.toDouble(),
          experienceYears: experienceYears == 0
              ? doctor.experienceYears
              : experienceYears,
          specializationId: 0,
          cv: file,
        );

      case ServiceRole.technician:
        // TODO: Handle this case.
        throw UnimplementedError();
      case ServiceRole.restaurantOwner:
        // TODO: Handle this case.
        throw UnimplementedError();
      case ServiceRole.gymOwner:
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }
}
