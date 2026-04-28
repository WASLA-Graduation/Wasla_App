import 'package:dartz/dartz.dart';
import 'package:wasla/core/error/failure.dart';
import 'package:wasla/features/driver/features/home/data/models/driver_chart_data_model.dart';
import 'package:wasla/features/driver/features/home/data/models/driver_profile_model.dart';

abstract class DriverRepo {
  Future<Either<Failure, DriverProfileModel>> getDriverProfile({
    required String id,
  });
  Future<Either<Failure, DriverStatisticsModel>> getDriverChart({
    required String driverId,
  });
}
