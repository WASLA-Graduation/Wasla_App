import 'package:dartz/dartz.dart';
import 'package:wasla/core/error/failure.dart';
import 'package:wasla/features/restaurant/home/data/models/resturant_chart_model.dart';

abstract class RestaurantDashboardRepo {
  Future<Either<Failure, ResturantChartModel>> getRestaurantChart({
    required String restaurantId,
  });
}
