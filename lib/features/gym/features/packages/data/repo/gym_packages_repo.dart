import 'package:dartz/dartz.dart';
import 'package:wasla/features/gym/features/packages/data/models/gym_package_model.dart';

abstract class GymPackagesRepo {
  Future<Either<String, List<GymPackageModel>>> getGymPackagesAndOffers({
    required String gymId,
  });
  Future<Either<String, Null>> addOrUpdatePackageOrOffer({
    required GymPackageRequestModel model,
    required bool isAdding,
  });
  Future<Either<String, Null>> deletePackageOrOffer({required int serviceId});
}
