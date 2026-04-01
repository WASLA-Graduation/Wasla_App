import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:wasla/core/database/api/api_consumer.dart';
import 'package:wasla/core/database/api/api_end_points.dart';
import 'package:wasla/core/database/api/api_keys.dart';
import 'package:wasla/core/database/api/errors/api_exceptions.dart';
import 'package:wasla/core/functions/convert_image_to_json.dart';
import 'package:wasla/features/gym/features/packages/data/models/gym_package_model.dart';
import 'package:wasla/features/gym/features/packages/data/repo/gym_packages_repo.dart';

class GymPackagesRepoImpl extends GymPackagesRepo {
  final ApiConsumer api;

  GymPackagesRepoImpl({required this.api});

  @override
  Future<Either<String, List<GymPackageModel>>> getGymPackagesAndOffers({
    required String gymId,
  }) async {
    try {
      final response = await api.get(
        ApiEndPoints.gymPackage,
        queryParameters: {ApiKeys.serviceProviderId: gymId},
      );
      final packages = (response[ApiKeys.data] as List)
          .map((e) => GymPackageModel.fromJson(e))
          .toList();

      return Right(packages);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  @override
  @override
  Future<Either<String, Null>> deletePackageOrOffer({
    required int serviceId,
  }) async {
    try {
      await api.delete(
        ApiEndPoints.gymPackage,
        queryParameters: {ApiKeys.serviceIdCapital: serviceId},
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  @override
  Future<Either<String, Null>> addPackageOrOffer({
    required String serviceProviderId,
    required String nameArabic,
    required String nameEnglish,
    required String descriptionArabic,
    required String descriptionEnglish,
    required double price,
    required int durationInMonths,
    required double precentage,
    required int type,
    required File image,
  }) async {
    try {
      final formData = FormData.fromMap({
        ApiKeys.serviceProviderId: serviceProviderId,
        ApiKeys.nameEnglish: nameEnglish,
        ApiKeys.nameArabic: nameArabic,
        ApiKeys.descriptionEnglishDot: descriptionEnglish,
        ApiKeys.descriptionArabicDot: descriptionArabic,
        ApiKeys.price: price,
        ApiKeys.durationInMonths: durationInMonths,
        ApiKeys.precentage: precentage,
        ApiKeys.type: type,
        ApiKeys.photo: await convertImageToMultipart(image),
      });
      await api.post(
        ApiEndPoints.gymPackage,
        body: formData,
        headers: {"Content-Type": "multipart/form-data"},
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  @override
  Future<Either<String, Null>> updatePackageOrOffer({
    required int id,
    required String nameArabic,
    required String nameEnglish,
    required String descriptionArabic,
    required String descriptionEnglish,
    required double price,
    required double precentage,
    required int type,
    File? image,
  }) async {
    try {
    
      final formData = FormData.fromMap({
        ApiKeys.id: id,
        ApiKeys.nameArabic: nameArabic,
        ApiKeys.nameEnglish: nameEnglish,
        ApiKeys.descriptionArabicDot: descriptionArabic,
        ApiKeys.descriptionEnglishDot: descriptionEnglish,
        ApiKeys.price: price,
        ApiKeys.precentage: precentage,
        ApiKeys.type: type,
        if (image != null) ApiKeys.photo: await convertImageToMultipart(image),
      });
      await api.put(
        ApiEndPoints.gymPackage,
        body: formData,
        headers: {"Content-Type": "multipart/form-data"},
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }
}
