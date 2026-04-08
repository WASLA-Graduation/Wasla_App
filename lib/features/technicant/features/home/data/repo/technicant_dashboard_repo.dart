import 'package:dartz/dartz.dart';
import 'package:wasla/core/error/failure.dart';
import 'package:wasla/features/driver/features/home/data/models/technician_statistics_model.dart';

abstract class TechnicantDashboardRepo {
  Future<Either<Failure, TechnicianStatisticsModel>> getTechnicianChart({
    required String id,
  });
}
