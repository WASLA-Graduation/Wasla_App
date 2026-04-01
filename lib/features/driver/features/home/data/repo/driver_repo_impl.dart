import 'package:dartz/dartz.dart';
import 'package:wasla/core/database/api/api_consumer.dart';
import 'package:wasla/core/database/api/api_end_points.dart';
import 'package:wasla/core/database/api/api_keys.dart';
import 'package:wasla/core/database/api/errors/api_exceptions.dart';
import 'package:wasla/features/driver/features/home/data/models/driver_chart_data_model.dart';
import 'package:wasla/features/driver/features/home/data/models/driver_profile_model.dart';
import 'package:wasla/features/driver/features/home/data/repo/driver_repo.dart';

class DriverRepoImpl extends DriverRepo {
  final ApiConsumer api;

  DriverRepoImpl({required this.api});

  @override
  Future<Either<String, DriverProfileModel>> getDriverProfile({
    required String id,
  }) async {
    try {
      final response = await api.get(
        ApiEndPoints.getDriverProfile,
        queryParameters: {ApiKeys.id: id},
      );
      return Right(DriverProfileModel.fromJson(response[ApiKeys.data]));
    } on ServerException catch (error) {
      return Left(error.errorModel.errorMessage);
    }
  }

  @override
  Future<Either<String, DriverStatisticsModel>> getDriverChart({
    required String driverId,
  }) async {
    try {
      final response = await api.get(ApiEndPoints.getDriverChart + driverId);
      return Right(DriverStatisticsModel.fromJson(response[ApiKeys.data]));
    } on ServerException catch (error) {
      return Left(error.errorModel.errorMessage);
    }
  }
}
