import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/database/api/api_keys.dart';
import 'package:wasla/core/database/cache/secure_storage_helper.dart';
import 'package:wasla/core/enums/driver_enums.dart';
import 'package:wasla/core/enums/service_role.dart';
import 'package:wasla/core/functions/get_service_role.dart';
import 'package:wasla/core/functions/validate_text_form_field.dart';
import 'package:wasla/core/models/user_base_model.dart';
import 'package:wasla/core/repo/global_repo.dart';
import 'package:wasla/features/doctor_service/features/home/data/models/doctor_model.dart';
import 'package:wasla/features/driver/features/home/data/models/driver_profile_model.dart';
import 'package:wasla/features/profile/data/models/gym_model.dart';
import 'package:wasla/features/profile/data/repo/profile_repo.dart';
import 'package:wasla/features/restaurant/home/data/models/restaurant_model.dart';
import 'package:wasla/features/technicant/features/home/data/models/technician_model.dart';
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
      universityName = '',
      ownerName = '',
      businessName = '',
      description = '',
      gymPhones = '',
      email = '',
      vehicleModel = '',
      vehicleNumber = '',
      serviceName = '';

  int experienceYears = 0, specializationId = 0;
  double lat = 0, lng = 0;
  bool isPasswordVisible = false;
  UserBaseModel? user;
  List<PlatformFile> technicantDocuments = [];

  final residentFormKey = GlobalKey<FormState>();
  final changePassFormKey = GlobalKey<FormState>();
  final gymFormKey = GlobalKey<FormState>();
  final driverFormKey = GlobalKey<FormState>();
  final technicainFormKey = GlobalKey<FormState>();
  final restaurantFormKey = GlobalKey<FormState>();
  File? image;
  List<File> images = [];
  List<PlatformFile> files = [];
  List<File> restaurantGalary = [];
  VehicleType vehicleType = VehicleType.car;
  int vehicleColor = -1;
  int technicainSpecialityId = -1;

  Future<void> addContact({
    required String fullName,
    required String email,
    required String message,
  }) async {
    emit(HelpCenterAddContactLoading());
    final res = await profileRepo.contacktWithAdmin(
      email: email,
      fullName: fullName,
      message: message,
    );
    res.fold(
      (l) => emit(HelpCenterAddContactFailure(errMsg: l)),
      (r) => emit(HelpCenterAddContactSuccess()),
    );
  }

  void updateTechnicantDocuments(List<PlatformFile> documents) {
    technicantDocuments = documents;
    emit(ProfileUpdateTechnicantDocuments());
  }

  void updateTechnicianSpeciality({required int specialityId}) {
    technicainSpecialityId = specialityId;
    emit(ProfileUpdateTechnicantSpecialization());
  }

  void updateRestaurantGalary(List<File> galary) {
    restaurantGalary = galary;
    emit(ProfileUpdate());
  }

  void updateVehicleColor(int color) {
    vehicleColor = color;
    emit(ProfileUpdate());
  }

  void toggglePassIcon() {
    isPasswordVisible = !isPasswordVisible;
    emit(ProfileUpdate());
  }

  void updateFile(PlatformFile f) {
    file = f;
    emit(ProfileUpdate());
  }

  void uploadIImages(List<File> f) {
    images = f;
    emit(ProfileUpdate());
  }

  void updateVehicleType(VehicleType f) {
    vehicleType = f;
    emit(ProfileUpdate());
  }

  void uploadFiles(List<PlatformFile> f) {
    files = f;
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
    images = [];
    gymPhones = '';
    serviceName = '';
    email = '';
    ownerName = '';
    businessName = '';
    description = '';
    vehicleModel = '';
    vehicleNumber = '';
    vehicleType = VehicleType.car;
    vehicleColor = -1;
    technicainSpecialityId = -1;
    files = [];
    technicantDocuments = [];
  }

  _getRightProfileAccordingToRole({required String userId}) async {
    switch (getServiceRole()) {
      case ServiceRole.resident:
        return await profileRepo.getResidentProfile(userId: userId);
      case ServiceRole.driver:
        return await profileRepo.getDriverProfile(id: userId);
      case ServiceRole.doctor:
        return await profileRepo.getDoctorProfile(userId: userId);
      case ServiceRole.technician:
        return await GlobalRepo.getTechnicianProfile(technicianId: userId);
      case ServiceRole.restaurantOwner:
        return await GlobalRepo.getRestaurantProfile(resturantId: userId);

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
        final driver = user as DriverProfileModel;
        return await profileRepo.driverUpdateProfile(
          id: userId,
          description: description.isEmpty ? driver.description : description,
          drivingExperienceYears: experienceYears == 0
              ? driver.drivingExperienceYears
              : experienceYears,
          fullName: fullName.isEmpty ? driver.fullNameBase : fullName,
          phone: phoneNumber.isEmpty ? driver.phoneNumberBase : phoneNumber,
          lat: lat == 0 ? driver.latitude : lat,
          lng: lng == 0 ? driver.longitude : lng,
          profilePhoto: image,
          vehicleType: vehicleType.index,
          vehicleColor: vehicleColor == -1 ? 1 : vehicleColor,
          // vehicleModel: vehicleModel.isEmpty ? driver.vehicleModel : vehicleModel,
          vehicleModel: '2026',
          vehicleNumber: vehicleNumber.isEmpty
              ? driver.vehicleNumber
              : vehicleNumber,
          files: files,
          carImages: images,
        );
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
        final technician = user as TechnicianModel;
        return await profileRepo.technicianUpdateProfile(
          fullName: fullName.isEmpty ? technician.fullNameBase : fullName,
          phone: phoneNumber.isEmpty ? technician.phoneNumberBase : phoneNumber,
          lat: lat == 0 ? technician.latitude : lat,
          lng: lng == 0 ? technician.longitude : lng,
          photo: image,
          id: userId,
          experienceYears: experienceYears == 0
              ? technician.experienceYears
              : experienceYears,
          specialty: technicainSpecialityId == -1
              ? technician.specialty
              : technicainSpecialityId,
          technicantDocuments: technicantDocuments,
          bDate: technician.birthDay,
          description: description.isEmpty
              ? technician.description
              : description,
        );
      case ServiceRole.restaurantOwner:
        final restaurant = user as RestaurantModel;

        return await profileRepo.restaurantUpdateProfile(
          id: restaurant.id,
          description: description.isEmpty
              ? restaurant.description
              : description,
          existingFiles: restaurant.gallery.map((p) => p).toList(),
          owenerName: ownerName.isEmpty ? restaurant.ownerName : ownerName,
          restaurantName: serviceName.isEmpty ? restaurant.name : serviceName,
          profile: image,
          phone: phoneNumber.isEmpty ? restaurant.phoneNumber : phoneNumber,
          restaurantCategoryId: restaurant.restaurantCategoryId,
          newFiles: null,
        );

      case ServiceRole.gymOwner:
        final gym = user as GymModel;
        return await profileRepo.updateGymInfo(
          businessName: businessName.isEmpty ? gym.businessName : businessName,
          description: description.isEmpty ? gym.description : description,
          gmail: email.isEmpty ? gym.email : email,
          lat: lat == 0 ? gym.latBase : lat,
          lng: lng == 0 ? gym.lngBase : lng,
          ownerName: ownerName.isEmpty ? gym.ownerName : ownerName,
          // ownerName:'Disha',
          phones: gymPhones.isEmpty
              ? gym.phones
              : extractEgyptPhones(gymPhones)!,
          gymGalary: images.isEmpty ? null : images,
          photo: image,
        );
    }
  }
}
