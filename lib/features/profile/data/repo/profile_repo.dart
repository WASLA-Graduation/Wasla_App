import 'dart:io';

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
  Future<Either<String, Null>> updateResidentInfo({
    required String userId,
    required String fullName,
    required String phone,
    required double lat,
    required double lng,
    File? image,
  });
}
