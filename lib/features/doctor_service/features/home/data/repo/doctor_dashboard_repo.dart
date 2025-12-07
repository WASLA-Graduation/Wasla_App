import 'package:dartz/dartz.dart';
import 'package:wasla/features/doctor_service/features/home/data/models/doctor_chart_model.dart';

abstract class DoctorDashboardRepo {
  Future<Either<String, DoctorChartModel>> getDoctorChart({
    required String doctorId,
  });
}
