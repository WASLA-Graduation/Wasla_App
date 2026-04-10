import 'package:dartz/dartz.dart';
import 'package:wasla/core/error/failure.dart';
import 'package:wasla/features/resident_service/features/technicain/data/models/resident_technician_model.dart';
import 'package:wasla/features/resident_service/features/technicain/data/models/technician_specialization_model.dart';

abstract class ResidentTechnicianRepo {
  Future<Either<Failure, List<TechnicianSpecializationModel>>>
  getTechnicianSpecialization();
  Future<Either<Failure, List<ResidentTechnicianModel>>>
  getTechniciansBySpeciality({
    required int speciality,
    required int pageNumber,
    required int pageSize,
  });
}
