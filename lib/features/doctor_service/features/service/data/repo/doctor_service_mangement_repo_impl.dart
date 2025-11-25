import 'package:dartz/dartz.dart';
import 'package:wasla/core/database/api/api_consumer.dart';
import 'package:wasla/core/database/api/api_end_points.dart';
import 'package:wasla/core/database/api/api_keys.dart';
import 'package:wasla/core/database/api/errors/api_exceptions.dart';
import 'package:wasla/features/doctor_service/features/service/data/models/doctor_service_model.dart';
import 'package:wasla/features/doctor_service/features/service/data/repo/doctor_service_mangement_repo.dart';

class DoctorServiceMangementRepoImpl extends DoctorServiceMangementRepo {
  final ApiConsumer api;

  DoctorServiceMangementRepoImpl({required this.api});
  @override
  Future<Either<String, List<DoctorServiceModel>>> getDoctorService({
    required String userId,
  }) async {
    try {
      final response = await api.get(ApiEndPoints.doctorGetServices + userId);
      final List<DoctorServiceModel> services = [];
      for (var service in response[ApiKeys.data]) {
        services.add(DoctorServiceModel.fromJson(service));
      }
      return Right(services);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  @override
  Future<Either<String, Null>> deleteDoctorService({
    required int serviceId,
  }) async {
    try {
      await api.delete("${ApiEndPoints.doctorDeleteService}$serviceId");
      return Right(null);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  @override
  Future<Either<String, Null>> addDoctorService({
    required String doctorId,
    required Map<String, String> serviceName,
    required Map<String, String> description,
    required List<ServiceDay> serviceDays,
    required List<ServiceDate> serviceDates,
    required List<TimeSlot> timeSlots,
    required double price,
  }) async {
    try {
      await api.post(
        ApiEndPoints.doctorAddService,
        body: {
          ApiKeys.doctorId: doctorId,
          ApiKeys.serviceName: serviceName,
          ApiKeys.description: description,
          ApiKeys.serviceDays: serviceDays.map((e) => e.toJson()).toList(),
          ApiKeys.serviceDates: serviceDates.map((e) => e.toJson()).toList(),
          ApiKeys.timeSlots: timeSlots.map((e) => e.toJson()).toList(),
          ApiKeys.price: price,
        },
      );
      return Right(null);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  @override
  Future<Either<String, Null>> updateDoctorService({
    required int serviceId,
    required Map<String, String> serviceName,
    required Map<String, String> description,
    required List<ServiceDay> serviceDays,
    required List<ServiceDate> serviceDates,
    required List<TimeSlot> timeSlots,
    required double price,
  }) async {
    try {
      await api.put(
        ApiEndPoints.doctorUpdateService,
        body: {
          ApiKeys.serviceId: serviceId,
          ApiKeys.serviceName: serviceName,
          ApiKeys.description: description,
          ApiKeys.serviceDays: serviceDays
              .map((e) => e.toJsonWithId())
              .toList(),
          ApiKeys.serviceDates: serviceDates
              .map((e) => e.toJsonWithId())
              .toList(),
          ApiKeys.timeSlots: timeSlots.map((e) => e.toJsonWithId()).toList(),
          ApiKeys.price: price,
        },
      );
      return Right(null);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }
}
