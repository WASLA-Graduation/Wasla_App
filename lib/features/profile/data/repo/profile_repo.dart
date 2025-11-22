import 'package:dartz/dartz.dart';
import 'package:wasla/core/models/user_model.dart';

abstract class ProfileRepo {
  Future<Either<String, UserModel>> getResidentProfile({
    required String userId,
  });
  Future<Either<String, Null>> changePassword({
    required String email,
    required String currentPassword,
    required String newPassword,
  });
}
