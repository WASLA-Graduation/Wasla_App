import 'package:dartz/dartz.dart';
import 'package:wasla/core/error/failure.dart';
import 'package:wasla/features/restaurant/orders/data/model/resident_order_model.dart';
import 'package:wasla/features/restaurant/orders/data/model/restaurant_order_model.dart';
import 'package:wasla/features/restaurant/orders/data/model/restaurant_reservation_model.dart';

abstract class OrdersRepo {
  Future<Either<Failure, List<RestaurantReservationModel>>>
  getRestaurantReservations({
    required int pageSize,
    required int pageNumber,
    required String restaurantId,
  });

  Future<Either<String, Null>> changeReservationStatus({
    required int bookingId,
    required int status,
  });
  Future<Either<Failure, List<OrderModel>>> getOrdersForRestaurant({
    required String restaurantId,
    required int pageNumber,
    required int pageSize,
  });

  Future<Either<Failure, List<ResidentOrderModel>>> getOrdersForResidnt({
    required String residentId,
    required int pageNumber,
    required int pageSize,
  });
  Future<Either<String, Null>> markOrderAsDelivered({required int id});
  Future<Either<String, Null>> markOrderAsPrepared({required int id});
  Future<Either<String, Null>> cancelOrder({
    required int orderId,
    required bool isResident,
  });
}
