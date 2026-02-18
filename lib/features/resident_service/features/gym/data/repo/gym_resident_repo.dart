import 'package:dartz/dartz.dart';
import 'package:wasla/features/resident_service/features/gym/data/models/gym_data_model.dart';

abstract class GymResidentRepo {
  Future<Either<String, GymPaginationModel>> getAllGym({
    required int pageNumber,
    required int pageSize,
  });
}
