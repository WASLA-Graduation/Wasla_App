import 'package:dartz/dartz.dart';
import 'package:wasla/core/error/failure.dart';
import 'package:wasla/features/resident_service/features/restaurant/data/models/restauarant_menu_item_model.dart';
import 'package:wasla/features/resident_service/features/restaurant/data/models/restaurant_menu_category_model.dart';

abstract class ResidentMenuRepo {
  Future<Either<Failure, List<RestaurantMenuCategoryModel>>> getMenuCategories({
    required String restaurantId,
  });
  Future<Either<Failure, List<RestauarantMenuItemModel>>> getMenuItems({
    required String restaurantId,
  });
}
