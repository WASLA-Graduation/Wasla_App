import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:wasla/core/models/doctor_specializationa_model.dart';
import 'package:wasla/core/models/review_model.dart';
import 'package:wasla/features/doctor_service/features/service/data/models/doctor_service_model.dart';
import 'package:wasla/features/resident_service/features/doctor/data/models/doctor_data_model.dart';

abstract class DoctorRepo {
  Future<Either<String, List<DoctorSpecializationaModel>>> getSpecialization();
  Future<Either<String, List<DoctorDataModel>>> getDoctorsBySpecialization({
    required int specializationId,
  });

  Future<Either<String, List<DoctorServiceModel>>> getDoctorService({
    required String userId,
  });
  Future<Either<String, Null>> bookService({
    required String userId,
    required String doctorId,
    required int serviceDayId,
    required double price,
    required String bookingDate,
    required int bookingType,
    required int serviceProviderType,
    List<File>? images,
  });
  Future<Either<String, Null>> addReview({
    required String userId,
    required String comment,
    required int rating,
    required String serviceProviderId,
  });

  Future<Either<String, List<ReviewModel>>> getReview({required String userId});
}
