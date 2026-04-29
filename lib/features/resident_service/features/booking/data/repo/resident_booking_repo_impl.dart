
import 'package:dartz/dartz.dart';
import 'package:wasla/core/connection/network_info.dart';
import 'package:wasla/core/database/api/api_consumer.dart';
import 'package:wasla/core/database/api/api_end_points.dart';
import 'package:wasla/core/database/api/api_keys.dart';
import 'package:wasla/core/database/api/errors/api_exceptions.dart';
import 'package:wasla/core/error/failure.dart';
import 'package:wasla/core/service/service_locator.dart';
import 'package:wasla/features/resident_service/features/booking/data/models/resident_doctor_booking_model.dart';
import 'package:wasla/features/resident_service/features/booking/data/models/resident_driver_booking_model.dart';
import 'package:wasla/features/resident_service/features/booking/data/models/resident_gym_booking_model.dart';
import 'package:wasla/features/resident_service/features/booking/data/models/resident_restaurant_reservation_model.dart';
import 'package:wasla/features/resident_service/features/booking/data/models/resident_techician_booking_model.dart';
import 'package:wasla/features/resident_service/features/booking/data/repo/resident_booking_repo.dart';

class ResidentBookingRepoImpl extends ResidentBookingRepo {
  final ApiConsumer api;

  ResidentBookingRepoImpl({required this.api});

  @override
  Future<Either<Failure, List<DoctorResidentBookingModel>>>
  getResidentBookingsWithDoctor({required String userId}) async {
    try {
      if (!await sl<NetworkInfo>().isConnected) {
        return Left(NoInternetFailure());
      }
      final response = await api.get(
        ApiEndPoints.getBookingDetailsForUser,
        queryParameters: {ApiKeys.userId: userId},
      );
      final List<DoctorResidentBookingModel> bookings = [];
      for (var booking in response[ApiKeys.data]) {
        bookings.add(DoctorResidentBookingModel.fromJson(booking));
      }
      return Right(bookings);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorModel.errorMessage));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<String, Null>> doctorCancelBooking({
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
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<Failure, List<GymResidentBookingModel>>>
  getResidentBookingsWithGym({required String residentId}) async {
    try {
      if (!await sl<NetworkInfo>().isConnected) {
        return Left(NoInternetFailure());
      }
      final response = await api.get(
        ApiEndPoints.getResidentBookingsWithGym + residentId,
      );

      final List<GymResidentBookingModel> bookings = [];
      for (var booking in response[ApiKeys.data]) {
        if (booking[ApiKeys.isPaid]) {
          bookings.add(GymResidentBookingModel.fromJson(booking));
        }
      }
      return Right(bookings);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorModel.errorMessage));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<String, Null>> gymCancelBooking({
    required int bookingId,
  }) async {
    try {
      await api.put('${ApiEndPoints.gymCancelBooking}$bookingId');
      return const Right(null);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<Failure, List<ResidentDriverBookingModel>>>
  getBookingWithDriver({required String residentId}) async {
    try {
      if (!await sl<NetworkInfo>().isConnected) {
        return Left(NoInternetFailure());
      }
      final response = await api.get(
        ApiEndPoints.getResidentAllBookingsWithDriver + residentId,
      );
      final List<ResidentDriverBookingModel> bookings = [];
      for (var booking in response[ApiKeys.data]) {
        if (booking[ApiKeys.status] == 'Completed') {
          bookings.add(ResidentDriverBookingModel.fromJson(booking));
        }
      }
      return Right(bookings);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorModel.errorMessage));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ResidentTechicianBookingModel>>>
  getBookingWithTechnician({required String residentId}) async {
    try {
      if (!await sl<NetworkInfo>().isConnected) {
        return Left(NoInternetFailure());
      }
      final response = await api.get(
        ApiEndPoints.getBookingResidentWithTechnician + residentId,
      );

      final List<ResidentTechicianBookingModel> bookings = [];
      for (var booking in response[ApiKeys.data]) {
        bookings.add(ResidentTechicianBookingModel.fromJson(booking));
      }

      return Right(bookings);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorModel.errorMessage));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<String, Null>> technicainCancelBooking({
    required int bookingId,
  }) async {
    try {
      await api.put(
        ApiEndPoints.technicianCancelBooking + bookingId.toString(),
      );

      return const Right(null);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<Failure, List<ReservationModel>>> getBookingWithRestaurant({
    required String residentId,
  }) async {
    try {
      if (!await sl<NetworkInfo>().isConnected) {
        return Left(NoInternetFailure());
      }
      final response = await api.get(
        ApiEndPoints.getAllResevationOfResidentWithRestauant,
        queryParameters: {
          ApiKeys.id: residentId,
          ApiKeys.pageNumberCap: 1,
          ApiKeys.pageSizeCap: 10000000,
        },
      );

      final List<ReservationModel> bookings = [];

      for (var booking in response[ApiKeys.data][ApiKeys.data]) {
        bookings.add(ReservationModel.fromJson(booking));
      }

      return Right(bookings);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorModel.errorMessage));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<String, Null>> restaurantCancelBooking({
    required int bookingId,
  }) async {
    try {
      await api.put(
        ApiEndPoints.restaurantChangeStatusOfBooking,
        queryParameters: {ApiKeys.reservationId: bookingId, ApiKeys.status: 2},
      );

      return const Right(null);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    } catch (e) {
      return Left(e.toString());
    }
  }


}
