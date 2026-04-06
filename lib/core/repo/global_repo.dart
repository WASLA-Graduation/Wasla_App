import 'package:dartz/dartz.dart';
import 'package:wasla/core/connection/network_info.dart';
import 'package:wasla/core/database/api/api_consumer.dart';
import 'package:wasla/core/database/api/api_end_points.dart';
import 'package:wasla/core/database/api/api_keys.dart';
import 'package:wasla/core/database/api/errors/api_exceptions.dart';
import 'package:wasla/core/error/failure.dart';
import 'package:wasla/core/service/service_locator.dart';
import 'package:wasla/features/gym/features/packages/data/models/gym_package_model.dart';
import 'package:wasla/features/profile/data/models/gym_model.dart';
import 'package:wasla/features/technicant/features/home/data/models/technician_model.dart';

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

static  Future<Either<Failure, TechnicianModel>> getTechnicianProfile({
    required String technicianId,
  }) async {
    try {
      if (!await sl<NetworkInfo>().isConnected) {
        return Left(NoInternetFailure());
      }

      final response = await sl<ApiConsumer>().get(
        ApiEndPoints.technicantGetProfile,
        queryParameters: {ApiKeys.id: technicianId},
      );
      return Right(TechnicianModel.fromJson(response[ApiKeys.data]));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorModel.errorMessage));
    }
  }
}
