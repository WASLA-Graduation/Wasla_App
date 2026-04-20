import 'package:dartz/dartz.dart';
import 'package:wasla/core/error/failure.dart';
import 'package:wasla/features/auth/data/models/restaurant_catergories_model.dart';
import 'package:wasla/features/restaurant/home/data/models/restaurant_model.dart';

abstract class ResidentRestaurantRepo {
  Future<Either<Failure, List<RestaurantModel>>> getAllRestaurantsByCategory({
    required int categoryId,
    required int pageNumber,
    required int pageSize,
  });

  Future<Either<Failure, List<RestaurantCatergoriesModel>>>
  getRestaurantCategories();
  Future<Either<String, Null>> reservationWithRestaurant({
    required int numberOfPersons,
    required String userId,
    required String restaurantId,
    required String date,
    required String time,
  });
}
