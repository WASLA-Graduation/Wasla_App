import 'package:dartz/dartz.dart';
import 'package:wasla/core/connection/network_info.dart';
import 'package:wasla/core/database/api/api_consumer.dart';
import 'package:wasla/core/database/api/api_end_points.dart';
import 'package:wasla/core/database/api/api_keys.dart';
import 'package:wasla/core/database/api/errors/api_exceptions.dart';
import 'package:wasla/core/enums/booking_status.dart';
import 'package:wasla/core/error/failure.dart';
import 'package:wasla/core/service/service_locator.dart';
import 'package:wasla/features/gym/features/dashboard/data/models/gym_booking_model.dart';
import 'package:wasla/features/gym/features/dashboard/data/models/gym_statistics_model.dart';
import 'package:wasla/features/gym/features/dashboard/data/repo/gym_dashboard_repo.dart';
import 'package:wasla/features/profile/data/models/gym_model.dart';

class GymDashboardRepoImp extends GymDashboardRepo {
  final ApiConsumer api;

  GymDashboardRepoImp({required this.api});

  @override
  Future<Either<Failure, GymModel>> geGymProfile({
    required String gymId,
  }) async {
    try {
      if (!await sl<NetworkInfo>().isConnected) {
        return Left(NoInternetFailure());
      }
      final response = await api.get(
        ApiEndPoints.getGymProfile,

        queryParameters: {ApiKeys.id: gymId},
      );
      return Right(GymModel.fromJson(response[ApiKeys.data]));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorModel.errorMessage));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, GymStatisticsModel>> getGymCharts({
    required String gymId,
  }) async {
    try {
      if (!await sl<NetworkInfo>().isConnected) {
        return Left(NoInternetFailure());
      }
      final response = await api.get(ApiEndPoints.getGymCharts + gymId);
      return Right(GymStatisticsModel.fromJson(response));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorModel.errorMessage));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<GymBookingModel>>> getGymBookings({
    required String gymId,
    required BookingStatus status,
  }) async {
    try {
      if (!await sl<NetworkInfo>().isConnected) {
        return Left(NoInternetFailure());
      }
      final response = await api.get(
        '${ApiEndPoints.getGymAllBookings}$gymId/status/${status.toInt()}',
      );
      List<GymBookingModel> bookings = [];
      for (var booking in response[ApiKeys.data]) {
        bookings.add(GymBookingModel.fromJson(booking));
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
}
