import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:wasla/features/gym/features/packages/data/models/gym_package_model.dart';

abstract class GymPackagesRepo {
  Future<Either<String, List<GymPackageModel>>> getGymPackagesAndOffers({
    required String gymId,
  });
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
   required  File image,
  });
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
  });
  Future<Either<String, Null>> deletePackageOrOffer({required int serviceId});
}
