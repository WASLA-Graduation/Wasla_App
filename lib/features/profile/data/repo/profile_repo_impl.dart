import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:wasla/core/database/api/api_consumer.dart';
import 'package:wasla/core/database/api/api_end_points.dart';
import 'package:wasla/core/database/api/api_keys.dart';
import 'package:wasla/core/database/api/errors/api_exceptions.dart';
import 'package:wasla/features/doctor_service/features/home/data/models/doctor_model.dart';
import 'package:wasla/features/resident_service/features/home/data/models/user_model.dart';
import 'package:wasla/features/profile/data/repo/profile_repo.dart';

class ProfileRepoImpl extends ProfileRepo {
  final ApiConsumer api;
  ProfileRepoImpl({required this.api});

  @override
  Future<Either<String, UserModel>> getResidentProfile({
    required String userId,
  }) async {
    try {
      final response = await api.get(
        ApiEndPoints.residentGetProfile,
        queryParameters: {ApiKeys.userId: userId},
      );
      return Right(UserModel.fromJson(response[ApiKeys.data]));
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  @override
  Future<Either<String, Null>> changePassword({
    required String email,
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      await api.post(
        ApiEndPoints.resetPasswordForProfile,
        body: {
          ApiKeys.email: email,
          ApiKeys.currentPassword: currentPassword,
          ApiKeys.newPassword: newPassword,
        },
      );
      return Right(null);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  @override
  Future<Either<String, Null>> updateResidentInfo({
    required String userId,
    required String fullName,
    required String phone,
    required double lat,
    required double lng,
    File? image,
  }) async {
    try {
      await api.put(
        ApiEndPoints.residentEditProfile,
        queryParameters: {
          ApiKeys.id: userId,
          ApiKeys.fullname: fullName,
          ApiKeys.phoneSmall: phone,
          ApiKeys.latitudeSmall: lat,
          ApiKeys.longitudeSmall: lng,
        },
        body: FormData.fromMap({
          ApiKeys.imageSmall: image != null
              ? await MultipartFile.fromFile(
                  image.path,
                  filename: image.path.split('/').last,
                )
              : null,
        }),
        headers: {"Content-Type": "multipart/form-data"},
      );
      return Right(null);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  @override
  Future<Either<String, DoctorModel>> getDoctorProfile({
    required String userId,
  }) async {
    try {
      final response = await api.get(ApiEndPoints.doctorGetProfile + userId);
      return Right(DoctorModel.fromJson(response[ApiKeys.data]));
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }
}
