import 'package:dartz/dartz.dart';
import 'package:wasla/core/connection/network_info.dart';
import 'package:wasla/core/database/api/api_consumer.dart';
import 'package:wasla/core/database/api/api_end_points.dart';
import 'package:wasla/core/database/api/api_keys.dart';
import 'package:wasla/core/database/api/errors/api_exceptions.dart';
import 'package:wasla/core/error/failure.dart';
import 'package:wasla/core/service/service_locator.dart';
import 'package:wasla/features/restaurant/orders/data/model/restaurant_reservation_model.dart';
import 'package:wasla/features/restaurant/orders/data/repo/orders_repo.dart';

class OrdersRepoImpl extends OrdersRepo {
  final ApiConsumer api;

  OrdersRepoImpl({required this.api});

  @override
  Future<Either<Failure, List<RestaurantReservationModel>>> getRestaurantReservations({
    required int pageSize,
    required int pageNumber,
    required String restaurantId,
  }) async {
    try {
      if (!await sl<NetworkInfo>().isConnected) {
        return Left(NoInternetFailure());
      }
      final response = await api.get(
        ApiEndPoints.getReservationForRestaruant,
        queryParameters: {
          ApiKeys.id: restaurantId,
          ApiKeys.pageNumberCap: pageNumber,
          ApiKeys.pageSizeCap: pageSize,
        },
      );

      final List<RestaurantReservationModel> bookings = [];

      for (var booking in response[ApiKeys.data][ApiKeys.data]) {
        bookings.add(RestaurantReservationModel.fromJson(booking));
      }

      return Right(bookings);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorModel.errorMessage));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<String, Null>> changeReservationStatus({
    required int bookingId,
    required int status,
  }) async {
    try {
      await api.put(
        ApiEndPoints.restaurantChangeStatusOfBooking,
        queryParameters: {
          ApiKeys.reservationId: bookingId,
          ApiKeys.status: status,
        },
      );

      return const Right(null);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
