import 'package:dartz/dartz.dart';
import 'package:wasla/features/favourite/data/models/service_provider_fav_model.dart';

abstract class FavouriteRepo {
  Future<Either<String, ServiceProviderModel>> addToFavorite({
    required String residentId,
    required String serviceId,
  });

  Future<Either<String, Null>> removeFromFavorite({required int favouriteId});
  Future<Either<String, List<ServiceProviderModel>>> getAllFavourites({
    required String residentId,
  });
  Future<Either<String, List<ServiceProviderModel>>> getFavouritesByType({
    required String residentId,
    required int serviceType,
  });
}
