import 'package:dartz/dartz.dart';
import 'package:wasla/core/connection/network_info.dart';
import 'package:wasla/core/database/api/api_consumer.dart';
import 'package:wasla/core/database/api/api_end_points.dart';
import 'package:wasla/core/database/api/api_keys.dart';
import 'package:wasla/core/database/api/errors/api_exceptions.dart';
import 'package:wasla/core/error/failure.dart';
import 'package:wasla/core/service/service_locator.dart';
import 'package:wasla/features/auth/data/models/restaurant_catergories_model.dart';
import 'package:wasla/features/resident_service/features/restaurant/data/repo/details/resident_restaurant_repo.dart';
import 'package:wasla/features/restaurant/home/data/models/restaurant_model.dart';

class ResidentRestaurantRepoImpl extends ResidentRestaurantRepo {
  final ApiConsumer api;

  ResidentRestaurantRepoImpl({required this.api});

  @override
  Future<Either<Failure, List<RestaurantModel>>> getAllRestaurantsByCategory({
    required int categoryId,
    required int pageNumber,
    required int pageSize,
  }) async {
    try {
      if (!await sl<NetworkInfo>().isConnected) {
        return Left(NoInternetFailure());
      }

      final response = await api.get(
        ApiEndPoints.getAllRestaurants,
        queryParameters: {
          ApiKeys.id: categoryId,
          ApiKeys.pageNumberCap: pageNumber,
          ApiKeys.pageSizeCap: pageSize,
        },
      );

      List<RestaurantModel> restaurants = [];
      for (var restaurant in response[ApiKeys.data][ApiKeys.data]) {
        restaurants.add(RestaurantModel.fromJson(restaurant));
      }
      return Right(restaurants);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorModel.errorMessage));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<RestaurantCatergoriesModel>>>
  getRestaurantCategories() async {
    try {
      if (!await sl<NetworkInfo>().isConnected) {
        return Left(NoInternetFailure());
      }

      final response = await api.get(ApiEndPoints.getRestaurantCategories);
      final List<RestaurantCatergoriesModel> catergories = [];
      for (var catergory in response[ApiKeys.data]) {
        catergories.add(RestaurantCatergoriesModel.fromJson(catergory));
      }
      return Right(catergories);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorModel.errorMessage));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<String, Null>> reservationWithRestaurant({
    required int numberOfPersons,
    required String userId,
    required String restaurantId,
    required String date,
    required String time,
  }) async {
    try {
    
      await api.post(
        ApiEndPoints.restaurantReservatioin,
        body: {
          ApiKeys.userId: userId,
          ApiKeys.restaurantId: restaurantId,
          ApiKeys.numberOfPersons: numberOfPersons,
          ApiKeys.reservationDate: date,
          ApiKeys.reservationTime: time,
        },
      );
      return Right(null);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
