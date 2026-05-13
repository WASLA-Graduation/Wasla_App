import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';
import 'package:wasla/core/enums/otp_type.dart';
import 'package:wasla/core/models/doctor_specializationa_model.dart';
import 'package:wasla/features/auth/data/models/restaurant_catergories_model.dart';
import 'package:wasla/features/auth/data/models/roles_model.dart';
import 'package:wasla/features/auth/data/models/sign_in_model.dart';

abstract class AuthRepo {
  Future<Either<String, Null>> signUpWithEmailAndPassword({
    required String email,
    required String pass,
    required String role,
  });

  Future<Either<String, Null>> verifyEmail({
    required String email,
    required String verificationCode,
    required OtpType otpType,
  });
  Future<Either<String, Null>> forgotPassCheckEmail({
    required String email,
    required OtpType verificationType,
  });
  Future<Either<String, Null>> resetPassword({
    required String email,
    required String newPassword,
    required String otp,
  });
  Future<Either<String, SignInDataModel>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<Either<String, List<RolesModel>>> getRoles();
  Future<Either<String, List<DoctorSpecializationaModel>>> getSpecialization();
  Future<Either<String, Null>> residentCompleteInfo({
    required String email,
    required String fullName,
    required String nationalId,
    required String phone,
    required String bDate,
    required File image,
    required double lat,
    required double lng,
  });
  Future<Either<String, Null>> gymCompleteInfo({
    required String gmail,
    required String businessName,
    required String ownerName,
    required String description,
    required List<String> phones,
    required double latitude,
    required double longitude,
    required List<File> photos,
  });
  Future<Either<String, Null>> doctorCompleteInfo({
    required String email,
    required String fullName,
    required String phone,
    required String bDate,
    required String universtiyName,
    required String description,
    required String hospitalName,
    required File image,
    required double lat,
    required double lng,
    required double graduationYear,
    required int spacializationID,
    required int experienceYears,
    required PlatformFile cv,
  });

  Future<Either<String, Null>> logOut();

  Future<Either<String, Null>> driverCompleteInfo({
    required String email,
    required String fullName,
    required String phone,
    required String bDate,
    required int vehicleType,
    required String vehicleModel,
    required String vehicleNumber,
    required int drivingExperienceYears,
    required int vehicleColor,
    required double lng,
    required double lat,
    required String description,
    required File photo,
    required List<File> vehicleImages,
    required List<PlatformFile> driverFiles,
  });
  Future<Either<String, Null>> technicantCompleteInfo({
    required String email,
    required String fullName,
    required String phone,
    required String bDate,
    required int experienceYears,
    required int specialty,
    required double lng,
    required double lat,
    required String description,
    required File photo,
    required List<PlatformFile> technicantDocuments,
  });

  Future<Either<String, List<RestaurantCatergoriesModel>>>
  getRestaurantCategories();

  Future<Either<String, Null>> restaurantCompleteInfo({
    required String email,
    required String restaurantName,
    required String ownerName,
    required String description,
    required String phone,

    required int categoryId,
    required File photo,
    required List<File> restaurantImages,
  });
}
