import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:wasla/core/database/api/api_consumer.dart';
import 'package:wasla/core/database/api/api_end_points.dart';
import 'package:wasla/core/database/api/api_keys.dart';
import 'package:wasla/core/database/api/errors/api_exceptions.dart';
import 'package:wasla/core/models/doctor_specializationa_model.dart';
import 'package:wasla/core/models/review_model.dart';
import 'package:wasla/features/doctor_service/features/service/data/models/doctor_service_model.dart';
import 'package:wasla/features/doctor_service/features/service/presentation/widgets/add_service_view_body.dart';
import 'package:wasla/features/resident_service/features/doctor/data/models/doctor_data_model.dart';
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

  @override
  Future<Either<String, List<DoctorDataModel>>> getDoctorsBySpecialization({
    required int specializationId,
  }) async {
    try {
      final response = await api.get(
        ApiEndPoints.getDoctorBySpecialist + specializationId.toString(),
      );
      final List<DoctorDataModel> doctors = [];
      for (var doctor in response[ApiKeys.data]) {
        doctors.add(DoctorDataModel.fromJson(doctor));
      }
      return Right(doctors);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

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
  Future<Either<String, Null>> bookService({
    required String userId,
    required String doctorId,
    required int serviceDayId,
    required double price,
    required String bookingDate,
    required int bookingType,
    required int serviceProviderType,
    List<File>? images,
  }) async {
    try {
      await api.post(
        ApiEndPoints.doctorBookService,
        body: FormData.fromMap({
          ApiKeys.userId: userId,
          ApiKeys.serviceProviderId: doctorId,
          ApiKeys.serviceDayId: serviceDayId,
          ApiKeys.price: price,
          ApiKeys.bookingDate: bookingDate,
          ApiKeys.bookingType: bookingType,
          ApiKeys.serviceProviderType: 1,
          ApiKeys.images: images == null
              ? null
              : await _convertFilesToMultipart(images),
        }),

        headers: {"Content-Type": "multipart/form-data"},
      );
      return Right(null);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  Future<List<MultipartFile>> _convertFilesToMultipart(List<File> files) async {
    return Future.wait(
      files.map(
        (file) async => await MultipartFile.fromFile(
          file.path,
          filename: file.path.split('/').last,
        ),
      ),
    );
  }

  @override
  Future<Either<String, List<ReviewModel>>> getReview({
    required String userId,
  }) async {
    try {
      final response = await api.get(ApiEndPoints.getReviews + userId);
      final List<ReviewModel> reviews = [];
      for (var review in response[ApiKeys.data]) {
        reviews.add(ReviewModel.fromJson(review));
      }
      return Right(reviews);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  @override
  Future<Either<String, Null>> addReview({
    required String userId,
    required String comment,
    required int rating,
    required String serviceProviderId,
  }) async {
    try {
      await api.post(
        ApiEndPoints.addReview,
        body: {
          ApiKeys.userId: userId,
          ApiKeys.content: comment,
          ApiKeys.rating: rating,
          ApiKeys.serviceProviderId: serviceProviderId,
        },
      );
      return Right(null);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }
}
