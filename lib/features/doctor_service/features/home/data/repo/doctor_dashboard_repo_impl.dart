import 'package:dartz/dartz.dart';
import 'package:wasla/core/database/api/api_consumer.dart';
import 'package:wasla/core/database/api/api_end_points.dart';
import 'package:wasla/core/database/api/api_keys.dart';
import 'package:wasla/core/database/api/errors/api_exceptions.dart';
import 'package:wasla/features/doctor_service/features/home/data/models/doctor_booking_model.dart';
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

  @override
  Future<Either<String, List<DoctorBookingModel>>> getDoctorBookings({
    required String doctorId,
    required int status,
  }) async {
    try {
      final response = await api.get(
        '${ApiEndPoints.doctorGetAllBooking}$doctorId/$status',
      );
      final List<DoctorBookingModel> allBookings = [];
      for (var booking in response[ApiKeys.data]) {
        allBookings.add(DoctorBookingModel.fromJson(booking));
      }

      return Right(allBookings);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  @override
  Future<Either<String, Null>> removeBooking({
    required int bookingId,
    required int status,
  }) async {
    try {
      await api.put(
        ApiEndPoints.updateBookingStatus,
        queryParameters: {ApiKeys.bookingId: bookingId, ApiKeys.status: status},
      );

      return Right(null);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }
}
