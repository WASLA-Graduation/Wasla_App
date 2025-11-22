import 'package:dartz/dartz.dart';
import 'package:wasla/core/models/user_model.dart';

abstract class HomeRepo {
    Future<Either<String, UserModel>> getResidentProfile({required String userId});

}
