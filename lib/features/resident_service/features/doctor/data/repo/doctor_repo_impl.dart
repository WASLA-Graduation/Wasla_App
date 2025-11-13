import 'package:dartz/dartz.dart';
import 'package:wasla/core/database/api/api_consumer.dart';
import 'package:wasla/core/database/api/api_end_points.dart';
import 'package:wasla/core/database/api/api_keys.dart';
import 'package:wasla/core/database/api/errors/api_exceptions.dart';
import 'package:wasla/core/models/doctor_specializationa_model.dart';
import 'package:wasla/features/resident_service/features/doctor/data/repo/doctor_repo.dart';

class DoctorRepoImpl extends DoctorRepo {
  final ApiConsumer api;

  DoctorRepoImpl({required this.api});
  @override
  Future<Either<String, List<DoctorSpecializationaModel>>>
  getSpecialization() async {
    try {
      final response = await api.get(ApiEndPoints.getDoctorSpecializations);
      final List<DoctorSpecializationaModel> specializations = [];
      for (var specialization in response[ApiKeys.data]) {
        specializations.add(
          DoctorSpecializationaModel.fromJson(specialization),
        );
      }
      return Right(specializations);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }
}
