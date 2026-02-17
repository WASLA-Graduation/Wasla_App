import 'package:dartz/dartz.dart';
import 'package:wasla/features/gym/features/dashboard/data/models/gym_booking_model.dart';
import 'package:wasla/features/gym/features/dashboard/data/models/gym_statistics_model.dart';
import 'package:wasla/features/profile/data/models/gym_model.dart';

abstract class GymDashboardRepo {
  Future<Either<String, GymModel>> geGymProfile({required String gymId});
  Future<Either<String, GymStatisticsModel>> getGymCharts({
    required String gymId,
  });
  Future<Either<String, List<GymBookingModel>>> getGymBookings({
    required String gymId,
  });
}
