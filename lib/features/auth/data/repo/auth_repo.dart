import 'package:dartz/dartz.dart';
import 'package:wasla/features/auth/data/models/sign_in_model.dart';

abstract class AuthRepo {
  Future<Either<String, Null>> signUpWithEmailAndPassword({
    required String email,
    required String pass,
    required String role,
  });

  Future<Either<String, Null>> verifyEmail({
    required String email,
    required String verificationCode,
  });
  Future<Either<String, Null>> forgotPassCheckEmail({required String email});
  Future<Either<String, Null>> resetPassword({
    required String email,
    required String newPassword,
  });
  Future<Either<String, SignInDataModel>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
}
