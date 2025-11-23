import 'package:dartz/dartz.dart';
import 'package:wasla/features/resident_service/features/home/data/models/user_model.dart';

abstract class HomeRepo {
    Future<Either<String, UserModel>> getResidentProfile({required String userId});

}
