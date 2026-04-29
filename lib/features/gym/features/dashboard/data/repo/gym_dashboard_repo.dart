import 'package:dartz/dartz.dart';
import 'package:wasla/core/enums/booking_status.dart';
import 'package:wasla/core/error/failure.dart';
import 'package:wasla/features/gym/features/dashboard/data/models/gym_booking_model.dart';
import 'package:wasla/features/gym/features/dashboard/data/models/gym_statistics_model.dart';
import 'package:wasla/features/profile/data/models/gym_model.dart';

abstract class GymDashboardRepo {
  Future<Either<Failure, GymModel>> geGymProfile({required String gymId});
  Future<Either<Failure, GymStatisticsModel>> getGymCharts({
    required String gymId,
  });
  Future<Either<Failure, List<GymBookingModel>>> getGymBookings({
    required String gymId,
    required BookingStatus status,
  });
  Future<Either<String, Null>> gymCancelBooking({required int bookingId});
}
