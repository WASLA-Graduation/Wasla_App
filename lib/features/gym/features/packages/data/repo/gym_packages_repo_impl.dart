import 'package:wasla/core/database/api/api_consumer.dart';
import 'package:wasla/features/gym/features/packages/data/repo/gym_packages_repo.dart';

class GymPackagesRepoImpl extends GymPackagesRepo {
  final ApiConsumer api;

  GymPackagesRepoImpl({required this.api});
}
