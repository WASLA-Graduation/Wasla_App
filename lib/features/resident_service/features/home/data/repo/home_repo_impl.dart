import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:wasla/core/connection/network_info.dart';
import 'package:wasla/core/database/api/api_consumer.dart';
import 'package:wasla/core/database/api/api_end_points.dart';
import 'package:wasla/core/database/api/api_keys.dart';
import 'package:wasla/core/database/api/errors/api_exceptions.dart';
import 'package:wasla/core/error/failure.dart';
import 'package:wasla/core/service/service_locator.dart';
import 'package:wasla/features/resident_service/features/home/data/models/service_provieders_search_model.dart';
import 'package:wasla/features/resident_service/features/home/data/models/user_model.dart';
import 'package:wasla/features/resident_service/features/home/data/repo/home_repo.dart';

class HomeRepoImpl extends HomeRepo {
  final ApiConsumer api;

  HomeRepoImpl({required this.api});
  @override
  Future<Either<String, UserModel>> getResidentProfile({
    required String userId,
  }) async {
    try {
      final response = await api.get(
        ApiEndPoints.residentGetProfile,
        queryParameters: {ApiKeys.userId: userId},
      );
      return Right(UserModel.fromJson(response[ApiKeys.data]));
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  @override
  Future<Either<Failure, List<ServiceProviedersSearchModel>>>
  getAllServiceProviders({
    required int pageNumber,
    required int pageSize,
  }) async {
    try {
      if (!await sl<NetworkInfo>().isConnected) {
        return Left(NoInternetFailure());
      }
      final response = await api.get(
        'api/ServiceProvider/All',
        queryParameters: {
          ApiKeys.pageNumber: pageNumber,
          ApiKeys.pageSize: pageSize,
        },
      );

      List<ServiceProviedersSearchModel> result = [];

      for (var provider in response[ApiKeys.data][ApiKeys.data]) {
        result.add(ServiceProviedersSearchModel.fromJson(provider));
      }

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorModel.errorMessage));
    } catch (e) {
      log(e.toString());
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<String, List<ServiceProviedersSearchModel>>>
  searchAllServiceProviders({
    required int pageNumber,
    required int pageSize,
    required String query,
  }) async {
    try {
      final response = await api.get(
        ApiEndPoints.searchServiceProviders,
        queryParameters: {
          ApiKeys.pageNumber: pageNumber,
          ApiKeys.pageSize: pageSize,
          ApiKeys.query: query,
        },
      );

      List<ServiceProviedersSearchModel> result = [];

      for (var provider in response[ApiKeys.data][ApiKeys.data]) {
        result.add(ServiceProviedersSearchModel.fromJson(provider));
      }
      return Right(result);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
