import 'package:dartz/dartz.dart';
import 'package:wasla/core/database/api/api_consumer.dart';
import 'package:wasla/core/database/api/api_end_points.dart';
import 'package:wasla/core/database/api/api_keys.dart';
import 'package:wasla/core/database/api/errors/api_exceptions.dart';
import 'package:wasla/features/favourite/data/models/service_provider_fav_model.dart';
import 'package:wasla/features/favourite/data/repo/favourite_repo.dart';
import 'package:wasla/features/resident_service/features/doctor/data/models/doctor_data_model.dart';

class FavouriteRepoImpl extends FavouriteRepo {
  final ApiConsumer api;

  FavouriteRepoImpl({required this.api});

  @override
  Future<Either<String, ServiceProviderModel>> addToFavorite({
    required String residentId,
    required String serviceId,
  }) async {
    try {
      final response = await api.post(
        ApiEndPoints.addToFavourite,
        queryParameters: {
          ApiKeys.residentId: residentId,
          ApiKeys.serviceProviderId: serviceId,
        },
      );
      return Right(ServiceProviderModel.fromJson(response[ApiKeys.data]));
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  @override
  Future<Either<String, Null>> removeFromFavorite({
    required int favouriteId,
  }) async {
    try {
      await api.delete(
        ApiEndPoints.removeFromFavourite,
        queryParameters: {ApiKeys.favouriteId: favouriteId},
      );
      return Right(null);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  @override
  Future<Either<String, List<ServiceProviderModel>>> getAllFavourites({
    required String residentId,
  }) async {
    try {
      final response = await api.get(
        ApiEndPoints.getAllFavourites,
        queryParameters: {ApiKeys.residentId: residentId},
      );
      final List<ServiceProviderModel> providers =
          (response[ApiKeys.data] as List)
              .map((e) => ServiceProviderModel.fromJson(e))
              .toList();

      return Right(providers);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  @override
  Future<Either<String, List<ServiceProviderModel>>> getFavouritesByType({
    required String residentId,
    required int serviceType,
  }) async {
    try {
      final response = await api.get(
        ApiEndPoints.getFavouritesByType,
        queryParameters: {
          ApiKeys.residentId: residentId,
          ApiKeys.serviceType: serviceType,
        },
      );
      final List<ServiceProviderModel> providers =
          (response[ApiKeys.data] as List)
              .map((e) => ServiceProviderModel.fromJson(e))
              .toList();

      return Right(providers);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  @override
  Future<Either<String, DoctorDataModel>> getDoctorById({
    required String docId,
  }) async {
    try {
      final response = await api.get(ApiEndPoints.getDoctorById + docId);
      return Right(DoctorDataModel.fromJson(response[ApiKeys.data]));
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }
}
