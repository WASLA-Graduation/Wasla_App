import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/database/api/api_keys.dart';
import 'package:wasla/core/database/cache/secure_storage_helper.dart';
import 'package:wasla/core/models/user_model.dart';
import 'package:wasla/features/profile/data/repo/profile_repo.dart';
part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.profileRepo) : super(ProfileInitial());
  final ProfileRepo profileRepo;

  String fullName = '',
      phoneNumber = '',
      newPassword = '',
      currentPassword = '';
  double lat = 0, lng = 0;
  bool isPasswordVisible = false;
  UserModel? user;

  final residentFormKey = GlobalKey<FormState>();
  final changePassFormKey = GlobalKey<FormState>();
  File? image;

  void toggglePassIcon() {
    isPasswordVisible = !isPasswordVisible;
    emit(ProfileUpdate());
  }

  Future<void> getUserProfile() async {
    emit(ProfileGetProfileLoading());
    final String? userId = await SecureStorageHelper.get(key: ApiKeys.userId);
    final response = await profileRepo.getResidentProfile(userId: userId!);
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
      email: user!.email,
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

  Future<void> updateResidentInfo() async {
    emit(ProfileResidentUpdateInfoLoading());
    final String? userId = await SecureStorageHelper.get(key: ApiKeys.userId);

    final response = await profileRepo.updateResidentInfo(
      fullName: fullName.isEmpty ? user!.fullName : fullName,
      phone: phoneNumber.isEmpty ? user!.phoneNumber : phoneNumber,
      lat: lat == 0 ? user!.lat : lat,
      lng: lng == 0 ? user!.lng : lng,
      image: image,
      userId: userId!,
    );
    response.fold(
      (error) {
        emit(ProfileResidentUpdateInfoFailure(errMsg: error));
      },
      (success) async {
        await getUserProfile();
        _resetsVariables();
        emit(ProfileResidentUpdateInfoSuccess());
      },
    );
  }

  void _resetsVariables() {
    image = null;
    lat = 0;
    lat = 0;
    fullName = '';
    phoneNumber = '';
  }
}
