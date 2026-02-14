import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';
import 'package:wasla/features/doctor_service/features/home/data/models/doctor_model.dart';
import 'package:wasla/features/profile/data/models/gym_model.dart';
import 'package:wasla/features/resident_service/features/home/data/models/user_model.dart';

abstract class ProfileRepo {
  Future<Either<String, UserModel>> getResidentProfile({
    required String userId,
  });
  Future<Either<String, GymModel>> geGymProfile({
    required String gymId,
  });


  Future<Either<String, Null>> changePassword({
    required String email,
    required String currentPassword,
    required String newPassword,
  });
  Future<Either<String, Null>> updateResidentInfo({
    required String userId,
    required String fullName,
    required String phone,
    required double lat,
    required double lng,
    File? image,
  });

  Future<Either<String, DoctorModel>> getDoctorProfile({
    required String userId,
  });

  Future<Either<String, Null>> updateDoctorInfo({
    required String userId,
    required String fullName,
    required String phone,
    required String birthDay,
    required String universityName,
    required String hospitalName,
    required double lat,
    required double lng,
    required double graduationYear,
    required int experienceYears,
    int? specializationId,
    File? profilePhoto,
    PlatformFile? cv,
  });
}
