import 'package:dartz/dartz.dart';
import 'package:wasla/features/resident_service/features/booking/data/models/resident_booking_model.dart';

abstract class ResidentBookingRepo {
  Future<Either<String, List<ResidentBookingModel>>> getResidentBookings({
    required String userId,
  });

  Future<Either<String, Null>> removeBooking({
    required int bookingId,
    required int status,
  });
}
