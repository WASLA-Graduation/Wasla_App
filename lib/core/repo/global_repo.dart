import 'package:dartz/dartz.dart';
import 'package:wasla/core/database/api/api_consumer.dart';
import 'package:wasla/core/database/api/api_end_points.dart';
import 'package:wasla/core/database/api/api_keys.dart';
import 'package:wasla/core/database/api/errors/api_exceptions.dart';
import 'package:wasla/core/service/service_locator.dart';
import 'package:wasla/features/gym/features/packages/data/models/gym_package_model.dart';
import 'package:wasla/features/profile/data/models/gym_model.dart';

abstract class GlobalRepo {
  static Future<Either<String, GymModel>> geGymProfile({
    required String gymId,
  }) async {
    try {
      final response = await sl<ApiConsumer>().get(
        ApiEndPoints.getGymProfile,

        queryParameters: {ApiKeys.id: gymId},
      );
      return Right(GymModel.fromJson(response[ApiKeys.data]));
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  static Future<Either<String, List<GymPackageModel>>> getGymPackagesAndOffers({
    required String gymId,
  }) async {
    try {
      final response = await sl<ApiConsumer>().get(
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
}
