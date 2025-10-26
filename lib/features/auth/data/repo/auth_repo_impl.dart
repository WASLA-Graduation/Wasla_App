import 'package:dartz/dartz.dart';
import 'package:wasla/core/database/api/api_consumer.dart';
import 'package:wasla/core/database/api/api_end_points.dart';
import 'package:wasla/core/database/api/api_keys.dart';
import 'package:wasla/core/database/api/errors/api_exceptions.dart';
import 'package:wasla/features/auth/data/models/sign_in_model.dart';
import 'package:wasla/features/auth/data/repo/auth_repo.dart';

class AuthRepoImpl extends AuthRepo {
  final ApiConsumer api;

  AuthRepoImpl({required this.api});

  @override
  Future<Either<String, Null>> signUpWithEmailAndPassword({
    required String email,
    required String pass,
    required String role,
  }) async {
    try {
      await api.post(
        ApiEndPoints.register,
        body: {
          ApiKeys.email: email,
          ApiKeys.password: pass,
          ApiKeys.confirmPassword: pass,
          ApiKeys.role: role,
        },
      );
      return Right(null);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  @override
  Future<Either<String, Null>> verifyEmail({
    required String email,
    required String verificationCode,
  }) async {
    try {
      await api.post(
        ApiEndPoints.verifyEmail,
        body: {
          ApiKeys.email: email,
          ApiKeys.verificationCode: verificationCode,
        },
      );
      return Right(null);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  @override
  Future<Either<String, Null>> forgotPassCheckEmail({
    required String email,
  }) async {
    try {
      await api.post(
        ApiEndPoints.forgotPassCheckEmail,
        body: {ApiKeys.email: email},
      );
      return Right(null);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  @override
  Future<Either<String, Null>> resetPassword({
    required String email,
    required String newPassword,
  }) async {
    try {
      await api.post(
        ApiEndPoints.forgotPass,
        body: {ApiKeys.email: email, ApiKeys.newPassword: newPassword},
      );
      return Right(null);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  @override
  Future<Either<String, SignInDataModel>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await api.post(
        ApiEndPoints.login,
        body: {ApiKeys.email: email, ApiKeys.password: password},
      );
      return Right(SignInDataModel.fromJson(response));
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }
}
