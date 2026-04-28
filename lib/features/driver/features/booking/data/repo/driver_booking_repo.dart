import 'package:dartz/dartz.dart';
import 'package:wasla/core/error/failure.dart';
import 'package:wasla/features/driver/features/booking/data/models/driver_ride_bookings.dart';

abstract class DriverBookingRepo {
  Future<Either<Failure, List<DriverRideBookings>>> getDriverBookings({
    required String driverId,
  });
}
