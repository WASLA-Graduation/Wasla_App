import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/database/api/api_keys.dart';
import 'package:wasla/core/database/cache/shared_preferences_helper.dart';
import 'package:wasla/core/enums/service_role.dart';
import 'package:wasla/core/extensions/service_role_extension.dart';

String getRightRoute({required ServiceRole role}) {
  switch (role) {
    case ServiceRole.resident:
      return AppRoutes.residenBottomNavBar;
    case ServiceRole.driver:
      return AppRoutes.residentInfoScreen;

    case ServiceRole.doctor:
      return AppRoutes.doctorNavbarScreen;

    case ServiceRole.technician:
      return AppRoutes.residentInfoScreen;

    case ServiceRole.restaurantOwner:
      return AppRoutes.residentInfoScreen;

    case ServiceRole.gymOwner:
      return AppRoutes.residentInfoScreen;
  }
}

String getRightCompleteServiceRoute({required ServiceRole role}) {
  switch (role) {
    case ServiceRole.resident:
      return AppRoutes.residentInfoScreen;
    case ServiceRole.driver:
      return AppRoutes.residentInfoScreen;

    case ServiceRole.doctor:
      return AppRoutes.doctorInfoScreen;

    case ServiceRole.technician:
      return AppRoutes.residentInfoScreen;

    case ServiceRole.restaurantOwner:
      return AppRoutes.residentInfoScreen;

    case ServiceRole.gymOwner:
      return AppRoutes.residentInfoScreen;
  }
}

String getRightEditProfileRoute() {
  final String? role = SharedPreferencesHelper.get(key: ApiKeys.role);
  switch (ServiceRoleExtension.fromString(role!)) {
    case ServiceRole.resident:
      return AppRoutes.residentEditProfileScreen;
    case ServiceRole.driver:
      return AppRoutes.residentEditProfileScreen;

    case ServiceRole.doctor:
      return AppRoutes.residentEditProfileScreen;

    case ServiceRole.technician:
      return AppRoutes.residentEditProfileScreen;

    case ServiceRole.restaurantOwner:
      return AppRoutes.residentEditProfileScreen;

    case ServiceRole.gymOwner:
      return AppRoutes.residentEditProfileScreen;
  }
}
