import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';
import 'package:wasla/core/models/doctor_specializationa_model.dart';
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
  });
  Future<Either<String, Null>> forgotPassCheckEmail({required String email});
  Future<Either<String, Null>> resetPassword({
    required String email,
    required String newPassword,
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
    required File image ,
    required double lat,
    required double lng,
  });
  Future<Either<String, Null>> doctorCompleteInfo({
    required String email,
    required String fullName,
    required String phone,
    required String bDate,
    required String universtiyName,
    required String description,
    required File image,
    required double lat,
    required double lng,
    required double graduationYear,
    required int spacializationID,
    required int experienceYears,
    required PlatformFile cv,
  });
}
