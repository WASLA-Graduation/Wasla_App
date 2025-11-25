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
    required List<ServiceDay> serviceDays,
    required List<ServiceDate> serviceDates,
    required List<TimeSlot> timeSlots,
    required double price,
  });
  Future<Either<String, Null>> updateDoctorService({
    required int serviceId,
    required Map<String, String> serviceName,
    required Map<String, String> description,
    required List<ServiceDay> serviceDays,
    required List<ServiceDate> serviceDates,
    required List<TimeSlot> timeSlots,
    required double price,
  });
}
