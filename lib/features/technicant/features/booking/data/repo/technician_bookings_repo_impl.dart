import 'package:dartz/dartz.dart';
import 'package:wasla/core/connection/network_info.dart';
import 'package:wasla/core/database/api/api_consumer.dart';
import 'package:wasla/core/database/api/api_end_points.dart';
import 'package:wasla/core/database/api/api_keys.dart';
import 'package:wasla/core/database/api/errors/api_exceptions.dart';
import 'package:wasla/core/error/failure.dart';
import 'package:wasla/core/service/service_locator.dart';
import 'package:wasla/features/technicant/features/booking/data/models/technicain_booking_model.dart';
import 'package:wasla/features/technicant/features/booking/data/repo/technician_bookings_repo.dart';

class TechnicianBookingsRepoImpl extends TechnicianBookingsRepo {
  final ApiConsumer api;

  TechnicianBookingsRepoImpl({required this.api});

  @override
  Future<Either<Failure, List<TechnicainBookingModel>>> getBookings({
    required String technicainId,
  }) async {
    try {
      if (!await sl<NetworkInfo>().isConnected) {
        return left(NoInternetFailure());
      }

      final response = await api.get(
        ApiEndPoints.technicianGetBookings + technicainId,
      );

      final bookings = (response[ApiKeys.data] as List)
          .map((e) => TechnicainBookingModel.fromJson(e))
          .toList();
      return Right(bookings);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorModel.errorMessage));
    }
  }

  @override
  Future<Either<String, Null>> acceptBooking({required int bookingId}) async {
    try {
      await api.put(
        ApiEndPoints.technicianAcceptBooking + bookingId.toString(),
      );

      return const Right(null);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  @override
  Future<Either<String, Null>> cancelBooking({required int bookingId}) async {
    try {
      await api.put(
        ApiEndPoints.technicianCancelBooking + bookingId.toString(),
      );

      return const Right(null);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  @override
  Future<Either<String, Null>> rejectBooking({required int bookingId}) async {
    try {
      await api.put(
        ApiEndPoints.technicianRejectBooking + bookingId.toString(),
      );

      return const Right(null);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  @override
  Future<Either<Failure, TechnicainBookingModel>> getBookingDetails({
    required int bookingId,
  }) async {
    try {
      if (!await sl<NetworkInfo>().isConnected) {
        return left(NoInternetFailure());
      }

      final response = await api.get(
        ApiEndPoints.technicianGetBookingDetails + bookingId.toString(),
      );

      final booking = TechnicainBookingModel.fromJson(response[ApiKeys.data]);
      return Right(booking);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorModel.errorMessage));
    }
  }
}
