import 'package:dartz/dartz.dart';
import 'package:wasla/core/error/failure.dart';
import 'package:wasla/features/technicant/features/booking/data/models/technicain_booking_model.dart';

abstract class TechnicianBookingsRepo {
  Future<Either<Failure, List<TechnicainBookingModel>>> getBookings({
    required String technicainId,
  });
  Future<Either<Failure, TechnicainBookingModel>> getBookingDetails({
    required int bookingId,
  });
  Future<Either<String, Null>> acceptBooking({required int bookingId});
  Future<Either<String, Null>> cancelBooking({required int bookingId});
  Future<Either<String, Null>> rejectBooking({required int bookingId});
}
