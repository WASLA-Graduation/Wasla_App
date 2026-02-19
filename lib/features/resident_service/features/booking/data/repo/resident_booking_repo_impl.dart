import 'package:dartz/dartz.dart';
import 'package:wasla/core/database/api/api_consumer.dart';
import 'package:wasla/core/database/api/api_end_points.dart';
import 'package:wasla/core/database/api/api_keys.dart';
import 'package:wasla/core/database/api/errors/api_exceptions.dart';
import 'package:wasla/features/resident_service/features/booking/data/models/resident_booking_model.dart';
import 'package:wasla/features/resident_service/features/booking/data/models/resident_gym_booking_model.dart';
import 'package:wasla/features/resident_service/features/booking/data/repo/resident_booking_repo.dart';

class ResidentBookingRepoImpl extends ResidentBookingRepo {
  final ApiConsumer api;

  ResidentBookingRepoImpl({required this.api});

  @override
  Future<Either<String, List<ResidentBookingModel>>> getResidentBookings({
    required String userId,
  }) async {
    try {
      final response = await api.get(
        ApiEndPoints.getBookingDetailsForUser,
        queryParameters: {ApiKeys.userId: userId},
      );
      final List<ResidentBookingModel> bookings = [];
      for (var booking in response[ApiKeys.data]) {
        bookings.add(ResidentBookingModel.fromJson(booking));
      }
      return Right(bookings);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  @override
  Future<Either<String, Null>> removeBooking({
    required int bookingId,
    required int status,
  }) async {
    try {
      await api.put(
        ApiEndPoints.updateBookingStatus,
        queryParameters: {ApiKeys.bookingId: bookingId, ApiKeys.status: status},
      );

      return Right(null);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  @override
  Future<Either<String, List<GymResidentBookingModel>>>
  getResidentBookingsWithGym({required String residentId}) async {
    try {
      final response = await api.get(
        ApiEndPoints.getResidentBookingsWithGym + residentId,
      );
      final List<GymResidentBookingModel> bookings = [];
      for (var booking in response[ApiKeys.data]) {
        bookings.add(GymResidentBookingModel.fromJson(booking));
      }
      return Right(bookings);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }
}
