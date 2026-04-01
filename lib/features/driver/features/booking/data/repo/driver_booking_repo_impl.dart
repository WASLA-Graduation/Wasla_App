import 'package:dartz/dartz.dart';
import 'package:wasla/core/database/api/api_consumer.dart';
import 'package:wasla/core/database/api/api_end_points.dart';
import 'package:wasla/core/database/api/api_keys.dart';
import 'package:wasla/core/database/api/errors/api_exceptions.dart';
import 'package:wasla/features/driver/features/booking/data/models/driver_ride_bookings.dart';
import 'package:wasla/features/driver/features/booking/data/repo/driver_booking_repo.dart';

class DriverBookingRepoImpl extends DriverBookingRepo {
  final ApiConsumer api;

  DriverBookingRepoImpl({required this.api});

  @override
  Future<Either<String, List<DriverRideBookings>>> getDriverBookings({
    required String driverId,
  }) async {
    try {
      final response = await api.get(
        ApiEndPoints.getDriverAllBookingsWithResident + driverId,
      );
      List<DriverRideBookings> bookigs = [];
      for (var booking in response[ApiKeys.data]) {
        if (booking[ApiKeys.status] == 'Completed') {
          bookigs.add(DriverRideBookings.fromJson(booking));
        }
      }

      return Right(bookigs);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }
}
