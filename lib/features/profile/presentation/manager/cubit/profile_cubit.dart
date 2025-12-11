import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/database/api/api_keys.dart';
import 'package:wasla/core/database/cache/secure_storage_helper.dart';
import 'package:wasla/core/enums/service_role.dart';
import 'package:wasla/core/functions/get_service_role.dart';
import 'package:wasla/core/models/doctor_specializationa_model.dart';
import 'package:wasla/core/models/user_base_model.dart';
import 'package:wasla/features/doctor_service/features/home/data/models/doctor_model.dart';
import 'package:wasla/features/profile/data/repo/profile_repo.dart';
part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.profileRepo) : super(ProfileInitial());
  final ProfileRepo profileRepo;

  String fullName = '',
      phoneNumber = '',
      newPassword = '',
      currentPassword = '',
      hospitalName = '',
      universtiyName = '',
      description = '';

  double lat = 0, lng = 0;
  bool isPasswordVisible = false;
  UserBaseModel? user;
  int experience = 0;
  int specializationId = -1;

  final residentFormKey = GlobalKey<FormState>();
  final changePassFormKey = GlobalKey<FormState>();
  final doctorEditKey = GlobalKey<FormState>();
  File? image;
  List<DoctorSpecializationaModel> doctorSpecialization = [];

  void toggglePassIcon() {
    isPasswordVisible = !isPasswordVisible;
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

  Future<void> getDoctorSpecialization() async {
    doctorSpecialization.clear();
    final response = await profileRepo.getSpecialization();
    response.fold(
      (error) {
        emit(ProfileGetDocSpecializationFailure(errMsg: error));
      },
      (success) {
        doctorSpecialization = success;
        emit(ProfileGetDocSpecializationSuccess());
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
    experience = 0;
    hospitalName = '';
    universtiyName = '';
    description = '';
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
        // TODO: Handle this case.
        throw UnimplementedError();
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
        final DoctorModel doctor = user as DoctorModel;
        if (specializationId == -1) {
          emit(
            ProfileUpdateInfoFailure(errMsg: 'Please Choose Specialization'),
          );
          return;
        }
        await profileRepo.updateDoctorInfo(
          birthDay: doctor.birthDay,
          experienceYears: experience == 0
              ? doctor.experienceYears
              : experience,
          fullName: fullName.isEmpty ? doctor.fullName : fullName,
          graduationYear: doctor.graduationYear.toDouble(),
          hospitalName: hospitalName.isEmpty
              ? doctor.hospitalname
              : hospitalName,
          lat: lat == 0 ? user!.latBase : lat,
          lng: lng == 0 ? user!.lngBase : lng,
          phone: phoneNumber.isEmpty ? doctor.phone : phoneNumber,
          specializationId: specializationId,
          universityName: universtiyName.isEmpty
              ? doctor.universityName
              : universtiyName,
          userId: userId,
          image: image,
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
