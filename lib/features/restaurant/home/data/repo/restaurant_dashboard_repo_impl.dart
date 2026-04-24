import 'package:dartz/dartz.dart';
import 'package:wasla/core/connection/network_info.dart';
import 'package:wasla/core/database/api/api_consumer.dart';
import 'package:wasla/core/database/api/api_end_points.dart';
import 'package:wasla/core/database/api/api_keys.dart';
import 'package:wasla/core/database/api/errors/api_exceptions.dart';
import 'package:wasla/core/error/failure.dart';
import 'package:wasla/core/service/service_locator.dart';
import 'package:wasla/features/restaurant/home/data/models/resturant_chart_model.dart';
import 'package:wasla/features/restaurant/home/data/repo/restaurant_dashboard_repo.dart';

class RestaurantDashboardRepoImpl extends RestaurantDashboardRepo {
  final ApiConsumer api;

  RestaurantDashboardRepoImpl({required this.api});

  @override
  Future<Either<Failure, ResturantChartModel>> getRestaurantChart({
    required String restaurantId,
  }) async {
    try {
      if (!await sl<NetworkInfo>().isConnected) {
        return Left(NoInternetFailure());
      }
      final response = await api.get(
        ApiEndPoints.getRestaurantChart,
        queryParameters: {'id': restaurantId},
      );

      return Right(ResturantChartModel.fromJson(response[ApiKeys.data]));
    } on ServerException catch (e) {
      return left(ServerFailure(e.errorModel.errorMessage));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
