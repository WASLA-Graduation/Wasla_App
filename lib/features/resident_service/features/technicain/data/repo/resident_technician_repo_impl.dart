import 'package:dartz/dartz.dart';
import 'package:wasla/core/connection/network_info.dart';
import 'package:wasla/core/database/api/api_consumer.dart';
import 'package:wasla/core/database/api/api_end_points.dart';
import 'package:wasla/core/database/api/api_keys.dart';
import 'package:wasla/core/database/api/errors/api_exceptions.dart';
import 'package:wasla/core/error/failure.dart';
import 'package:wasla/core/service/service_locator.dart';
import 'package:wasla/features/resident_service/features/technicain/data/models/resident_technician_model.dart';
import 'package:wasla/features/resident_service/features/technicain/data/models/technician_specialization_model.dart';
import 'package:wasla/features/resident_service/features/technicain/data/repo/resident_technician_repo.dart';

class ResidentTechnicianRepoImpl extends ResidentTechnicianRepo {
  final ApiConsumer api;

  ResidentTechnicianRepoImpl({required this.api});

  @override
  Future<Either<Failure, List<TechnicianSpecializationModel>>>
  getTechnicianSpecialization() async {
    try {
      if (!await sl<NetworkInfo>().isConnected) {
        return Left(NoInternetFailure());
      }

      final response = await api.get(
        ApiEndPoints.getSpecializationsOfTechnician,
      );

      List<TechnicianSpecializationModel> specializations = [];
      for (var s in response[ApiKeys.data]) {
        specializations.add(TechnicianSpecializationModel.fromJson(s));
      }
      return Right(specializations);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorModel.errorMessage));
    }
  }

  @override
  Future<Either<Failure, List<ResidentTechnicianModel>>>
  getTechniciansBySpeciality({
    required int speciality,
    required int pageNumber,
    required int pageSize,
  }) async {
    try {
      if (!await sl<NetworkInfo>().isConnected) {
        return Left(NoInternetFailure());
      }

      final response = await api.get(
        ApiEndPoints.getTechniciansBySpeciality,
        queryParameters: {
          ApiKeys.pageNumber: pageNumber,
          ApiKeys.pageSize: pageSize,
          ApiKeys.specialtySmall: speciality,
        },
      );

      List<ResidentTechnicianModel> technicians = [];
      for (var s in response[ApiKeys.data][ApiKeys.data]) {
        technicians.add(ResidentTechnicianModel.fromJson(s));
      }
      return Right(technicians);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorModel.errorMessage));
    }
  }
}
