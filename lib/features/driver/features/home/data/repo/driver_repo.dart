import 'package:dartz/dartz.dart';
import 'package:wasla/features/driver/features/home/data/models/driver_chart_data_model.dart';
import 'package:wasla/features/driver/features/home/data/models/driver_profile_model.dart';

abstract class DriverRepo {
  Future<Either<String, DriverProfileModel>> getDriverProfile({
    required String id,
  });
  Future<Either<String, DriverStatisticsModel>> getDriverChart({
    required String driverId,
  });
}
