import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:wasla/core/connection/network_info.dart';
import 'package:wasla/core/database/api/api_consumer.dart';
import 'package:wasla/core/database/api/api_end_points.dart';
import 'package:wasla/core/database/api/api_keys.dart';
import 'package:wasla/core/database/api/errors/api_exceptions.dart';
import 'package:wasla/core/error/failure.dart';
import 'package:wasla/core/service/service_locator.dart';
import 'package:wasla/features/driver/features/home/data/models/technician_statistics_model.dart';
import 'package:wasla/features/technicant/features/home/data/repo/technicant_dashboard_repo.dart';

class TechnicantDashboardRepoImpl extends TechnicantDashboardRepo {
  final ApiConsumer api;

  TechnicantDashboardRepoImpl({required this.api});

  @override
  Future<Either<Failure, TechnicianStatisticsModel>> getTechnicianChart({
    required String id,
  }) async {
    try {
      if (!await sl<NetworkInfo>().isConnected) {
        return Left(NoInternetFailure());
      }

      final response = await api.get(
        ApiEndPoints.technicianGetChart,
        queryParameters: {'TechnicianId': id},
      );
            // log('$response');


      return Right(TechnicianStatisticsModel.fromJson(response[ApiKeys.data]));
    } on ServerException catch (e) {
      return left(ServerFailure(e.errorModel.errorMessage));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
