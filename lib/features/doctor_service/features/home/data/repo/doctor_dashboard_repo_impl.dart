import 'package:dartz/dartz.dart';
import 'package:wasla/core/database/api/api_consumer.dart';
import 'package:wasla/core/database/api/api_end_points.dart';
import 'package:wasla/core/database/api/api_keys.dart';
import 'package:wasla/core/database/api/errors/api_exceptions.dart';
import 'package:wasla/features/doctor_service/features/home/data/models/doctor_chart_model.dart';
import 'package:wasla/features/doctor_service/features/home/data/repo/doctor_dashboard_repo.dart';

class DoctorDashboardRepoImpl extends DoctorDashboardRepo {
  final ApiConsumer api;

  DoctorDashboardRepoImpl({required this.api});
  @override
  Future<Either<String, DoctorChartModel>> getDoctorChart({
    required String doctorId,
  }) async {
    try {
      final response = await api.get(ApiEndPoints.doctorGetChart + doctorId);
      final DoctorChartModel chart = DoctorChartModel.fromJson(
        response[ApiKeys.data],
      );

      return Right(chart);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }
}
