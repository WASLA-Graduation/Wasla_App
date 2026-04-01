import 'package:dartz/dartz.dart';
import 'package:wasla/features/driver/features/booking/data/models/driver_ride_bookings.dart';

abstract class DriverBookingRepo {
  Future<Either<String, List<DriverRideBookings>>> getDriverBookings({
    required String driverId,
  });
}
