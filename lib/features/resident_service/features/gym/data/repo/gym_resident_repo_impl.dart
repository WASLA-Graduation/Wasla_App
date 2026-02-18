import 'package:dartz/dartz.dart';
import 'package:wasla/core/database/api/api_consumer.dart';
import 'package:wasla/core/database/api/api_end_points.dart';
import 'package:wasla/core/database/api/api_keys.dart';
import 'package:wasla/core/database/api/errors/api_exceptions.dart';
import 'package:wasla/features/resident_service/features/gym/data/models/gym_data_model.dart';
import 'package:wasla/features/resident_service/features/gym/data/repo/gym_resident_repo.dart';

class GymResidentRepoImpl extends GymResidentRepo {
  final ApiConsumer api;

  GymResidentRepoImpl({required this.api});

  @override
  Future<Either<String, GymPaginationModel>> getAllGym({
    required int pageNumber,
    required int pageSize,
  }) async {
    try {
      final response = await api.get(
        ApiEndPoints.getAllGyms,
        queryParameters: {
          ApiKeys.pageNumber: pageNumber,
          ApiKeys.pageSize: pageSize,
        },
      );

      return Right(GymPaginationModel.fromJson(response[ApiKeys.data]));
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }
}
