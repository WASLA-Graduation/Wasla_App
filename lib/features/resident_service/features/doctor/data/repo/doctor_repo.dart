import 'package:dartz/dartz.dart';
import 'package:wasla/core/models/doctor_specializationa_model.dart';

abstract class DoctorRepo {
  Future<Either<String, List<DoctorSpecializationaModel>>> getSpecialization();
}
