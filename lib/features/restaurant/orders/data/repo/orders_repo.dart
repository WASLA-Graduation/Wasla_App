import 'package:dartz/dartz.dart';
import 'package:wasla/core/error/failure.dart';
import 'package:wasla/features/restaurant/orders/data/model/restaurant_reservation_model.dart';

abstract class OrdersRepo {
  Future<Either<Failure, List<RestaurantReservationModel>>> getRestaurantReservations({
    required int pageSize,
    required int pageNumber,
    required String restaurantId,
  });

  Future<Either<String, Null>> changeReservationStatus({
    required int bookingId,
    required int status,
  });
}
