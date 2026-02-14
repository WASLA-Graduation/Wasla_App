import 'package:dartz/dartz.dart';
import 'package:wasla/core/database/api/api_consumer.dart';
import 'package:wasla/core/database/api/api_end_points.dart';
import 'package:wasla/core/database/api/api_keys.dart';
import 'package:wasla/core/database/api/errors/api_exceptions.dart';
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
  Future<Either<String, Null>> addOrUpdatePackageOrOffer({
    required GymPackageRequestModel model,
    required bool isAdding,
  }) async {
    try {
      isAdding
          ? await api.post(ApiEndPoints.gymPackage, body: await model.toJson())
          : await api.put(ApiEndPoints.gymPackage, body: await model.toJson());
      return const Right(null);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

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
}
