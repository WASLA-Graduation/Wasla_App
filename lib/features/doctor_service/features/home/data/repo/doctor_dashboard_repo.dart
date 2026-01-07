import 'package:dartz/dartz.dart';
import 'package:wasla/features/doctor_service/features/home/data/models/doctor_booking_model.dart';
import 'package:wasla/features/doctor_service/features/home/data/models/doctor_chart_model.dart';
import 'package:wasla/features/doctor_service/features/home/data/models/doctor_model.dart';

abstract class DoctorDashboardRepo {
  Future<Either<String, DoctorChartModel>> getDoctorChart({
    required String doctorId,
  });
  Future<Either<String, Null>> removeBooking({
    required int bookingId,
    required int status,
  });
  Future<Either<String, List<DoctorBookingModel>>> getDoctorBookings({
    required String doctorId,
    required int status,
  });
  Future<Either<String, Null>> updateDoctorBooking({
    required int bookingId,
    required int dayofWeek,
    required String startTime,
    required String endTime,
    required String bookingDate,
  });
    Future<Either<String, DoctorModel>> getDoctorProfile({
    required String userId,
  });

}
