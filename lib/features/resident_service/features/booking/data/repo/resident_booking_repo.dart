import 'package:dartz/dartz.dart';
import 'package:wasla/core/error/failure.dart';
import 'package:wasla/features/resident_service/features/booking/data/models/resident_doctor_booking_model.dart';
import 'package:wasla/features/resident_service/features/booking/data/models/resident_driver_booking_model.dart';
import 'package:wasla/features/resident_service/features/booking/data/models/resident_gym_booking_model.dart';
import 'package:wasla/features/resident_service/features/booking/data/models/resident_restaurant_reservation_model.dart';
import 'package:wasla/features/resident_service/features/booking/data/models/resident_techician_booking_model.dart';

abstract class ResidentBookingRepo {
  Future<Either<Failure, List<DoctorResidentBookingModel>>>
  getResidentBookingsWithDoctor({required String userId});
  Future<Either<Failure, List<GymResidentBookingModel>>>
  getResidentBookingsWithGym({required String residentId});

  Future<Either<String, Null>> doctorCancelBooking({
    required int bookingId,
    required int status,
  });

  Future<Either<String, Null>> gymCancelBooking({required int bookingId});
  Future<Either<Failure, List<ResidentDriverBookingModel>>>
  getBookingWithDriver({required String residentId});
  Future<Either<Failure, List<ResidentTechicianBookingModel>>>
  getBookingWithTechnician({required String residentId});
  Future<Either<String, Null>> technicainCancelBooking({
    required int bookingId,
  });

  Future<Either<Failure, List<ReservationModel>>> getBookingWithRestaurant({
    required String residentId,
  });

  Future<Either<String, Null>> restaurantCancelBooking({
    required int bookingId,
  });


}
