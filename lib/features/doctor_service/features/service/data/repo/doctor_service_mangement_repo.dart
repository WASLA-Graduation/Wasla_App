import 'package:dartz/dartz.dart';
import 'package:wasla/features/doctor_service/features/service/data/models/doctor_service_model.dart';

abstract class DoctorServiceMangementRepo {
  Future<Either<String, List<DoctorServiceModel>>> getDoctorService({
    required String userId,
  });
  Future<Either<String, Null>> deleteDoctorService({required int serviceId});
  Future<Either<String, Null>> addDoctorService({
    required String doctorId,
    required Map<String, String> serviceName,
    required Map<String, String> description,
    required double price,
    required List<Map<String, int>> serviceDays,
    required List<Map<String, String>> timeSlots,
  });
  Future<Either<String, Null>> updateDoctorService({
    required int serviceId,
    required Map<String, String> serviceName,
    required Map<String, String> description,
    required double price,
    required List<Map<String, int>> serviceDays,
    required List<Map<String, String>> timeSlots,
  });
}
