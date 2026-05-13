import 'package:dartz/dartz.dart';
import 'package:wasla/core/connection/network_info.dart';
import 'package:wasla/core/database/api/api_consumer.dart';
import 'package:wasla/core/database/api/api_end_points.dart';
import 'package:wasla/core/database/api/api_keys.dart';
import 'package:wasla/core/database/api/errors/api_exceptions.dart';
import 'package:wasla/core/error/failure.dart';
import 'package:wasla/core/service/service_locator.dart';
import 'package:wasla/features/restaurant/orders/data/model/resident_order_model.dart';
import 'package:wasla/features/restaurant/orders/data/model/restaurant_order_model.dart';
import 'package:wasla/features/restaurant/orders/data/model/restaurant_reservation_model.dart';
import 'package:wasla/features/restaurant/orders/data/repo/orders_repo.dart';

class OrdersRepoImpl extends OrdersRepo {
  final ApiConsumer api;

  OrdersRepoImpl({required this.api});

  @override
  Future<Either<Failure, List<RestaurantReservationModel>>>
  getRestaurantReservations({
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
          ApiKeys.isResidentCamel: false,
        },
      );

      return const Right(null);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<Failure, List<OrderModel>>> getOrdersForRestaurant({
    required String restaurantId,
    required int pageNumber,
    required int pageSize,
  }) async {
    try {
      if (!await sl<NetworkInfo>().isConnected) {
        return Left(NoInternetFailure());
      }
      final response = await api.get(
        ApiEndPoints.getOrdersForRestaruant,
        queryParameters: {
          ApiKeys.id: restaurantId,
          ApiKeys.pageNumberCap: pageNumber,
          ApiKeys.pageSizeCap: pageSize,
        },
      );

      final List<OrderModel> orders = [];

      for (var order in response[ApiKeys.data][ApiKeys.data]) {
        if (order['paymentStatus'] == 1) {
          orders.add(OrderModel.fromJson(order));
        }
      }

      return Right(orders);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorModel.errorMessage));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ResidentOrderModel>>> getOrdersForResidnt({
    required String residentId,
    required int pageNumber,
    required int pageSize,
  }) async {
    try {
      if (!await sl<NetworkInfo>().isConnected) {
        return Left(NoInternetFailure());
      }

      final response = await api.get(
        ApiEndPoints.getResidentOrdersWithRestaurant,
        queryParameters: {
          ApiKeys.id: residentId,
          ApiKeys.pageNumberCap: pageNumber,
          ApiKeys.pageSizeCap: pageSize,
        },
      );

      final List<ResidentOrderModel> orders = [];

      for (var order in response[ApiKeys.data][ApiKeys.data]) {
        if (order['paymentStatus'] == 1) {
          orders.add(ResidentOrderModel.fromJson(order));
        }
      }

      return Right(orders);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorModel.errorMessage));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<String, Null>> markOrderAsDelivered({required int id}) async {
    try {
      await api.put(
        ApiEndPoints.restaurantMarkOrderAsDelivered,
        queryParameters: {ApiKeys.id: id},
      );

      return const Right(null);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, Null>> markOrderAsPrepared({required int id}) async {
    try {
      await api.put(
        ApiEndPoints.restaurantMarkOrderAsPreparing,
        queryParameters: {ApiKeys.id: id},
      );

      return const Right(null);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, Null>> cancelOrder({
    required int orderId,
    required bool isResident,
  }) async {
    try {
      await api.put(
        ApiEndPoints.cancelOrder,
        queryParameters: {
          ApiKeys.isResident: isResident,
          ApiKeys.orderId: orderId,
        },
      );
      return Right(null);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }
}
