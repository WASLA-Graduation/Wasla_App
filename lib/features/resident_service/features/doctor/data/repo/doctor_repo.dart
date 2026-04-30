import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:wasla/core/error/failure.dart';
import 'package:wasla/core/models/doctor_specializationa_model.dart';
import 'package:wasla/features/doctor_service/features/service/data/models/doctor_service_model.dart';
import 'package:wasla/features/resident_service/features/doctor/data/models/doctor_data_model.dart';

abstract class DoctorRepo {
  Future<Either<Failure, List<DoctorSpecializationaModel>>> getSpecialization();
  Future<Either<Failure, List<DoctorDataModel>>> getDoctorsBySpecialization({
    required int specializationId,
  });

  Future<Either<Failure, List<DoctorServiceModel>>> getDoctorService({
    required String userId,
  });
  Future<Either<String, int>> bookService({
    required int serviceId,
    required String userId,
    required String doctorId,
    required int serviceDayId,
    required double price,
    required String bookingDate,
    required int bookingType,
    required int serviceProviderType,
    List<File>? images,
  });
}
