import 'package:wasla/core/enums/service_role.dart';
import 'package:wasla/core/utils/assets.dart';

class ServiceRoleModel {
  final ServiceRole role;
  final String image;
  final String titleKey;

  ServiceRoleModel({
    required this.role,
    required this.image,
    required this.titleKey,
  });

  static List<ServiceRoleModel> roleServiceList = [
    ServiceRoleModel(
      role: ServiceRole.resident,
      image: Assets.assetsImagesResident,
      titleKey: 'resident',
    ),
    ServiceRoleModel(
      role: ServiceRole.driver,
      image: Assets.assetsImagesOnboardingOne,
      titleKey: 'driver',
    ),
    ServiceRoleModel(
      role: ServiceRole.doctor,
      image: Assets.assetsImagesOnboardingTwo,
      titleKey: 'doctor',
    ),
    ServiceRoleModel(
      role: ServiceRole.technician,
      image: Assets.assetsImagesOnboadingThree,
      titleKey: 'technician',
    ),
    ServiceRoleModel(
      role: ServiceRole.restaurantOwner,
      image: Assets.assetsImagesChief,
      titleKey: 'restaurantOwner',
    ),
    ServiceRoleModel(
      role: ServiceRole.gymOwner,
      image: Assets.assetsImagesFitness,
      titleKey: 'gymOwner',
    ),
  ];
}
