import 'package:dartz/dartz.dart';
import 'package:wasla/core/connection/network_info.dart';
import 'package:wasla/core/database/api/api_consumer.dart';
import 'package:wasla/core/database/api/api_end_points.dart';
import 'package:wasla/core/database/api/api_keys.dart';
import 'package:wasla/core/database/api/errors/api_exceptions.dart';
import 'package:wasla/core/error/failure.dart';
import 'package:wasla/core/service/service_locator.dart';
import 'package:wasla/features/resident_service/features/restaurant/data/models/restauarant_menu_item_model.dart';
import 'package:wasla/features/resident_service/features/restaurant/data/models/restaurant_menu_category_model.dart';
import 'package:wasla/features/restaurant/menu/data/repo/resident_menu_repo.dart';

class ResidentMenuRepoImpl extends ResidentMenuRepo {
  final ApiConsumer api;

  ResidentMenuRepoImpl({required this.api});

  @override
  Future<Either<Failure, List<RestaurantMenuCategoryModel>>> getMenuCategories({
    required String restaurantId,
  }) async {
    try {
      if (!await sl<NetworkInfo>().isConnected) {
        return Left(NoInternetFailure());
      }

      final response = await api.get(
        ApiEndPoints.getMenuCategory,
        queryParameters: {ApiKeys.id: restaurantId},
      );

      List<RestaurantMenuCategoryModel> categories = [];
      for (var category in response[ApiKeys.data] ?? []) {
        categories.add(RestaurantMenuCategoryModel.fromJson(category));
      }
      return Right(categories);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorModel.errorMessage));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<RestauarantMenuItemModel>>> getMenuItems({
    required String restaurantId,
  }) async {
    try {
      if (!await sl<NetworkInfo>().isConnected) {
        return Left(NoInternetFailure());
      }

      final response = await api.get(
        ApiEndPoints.getMenuCategoryItemByCategories,
        queryParameters: {ApiKeys.id: restaurantId},
      );

      List<RestauarantMenuItemModel> items = [];
      for (var item in response[ApiKeys.data] ?? []) {
        items.add(RestauarantMenuItemModel.fromJson(item));
      }
      return Right(items);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorModel.errorMessage));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
