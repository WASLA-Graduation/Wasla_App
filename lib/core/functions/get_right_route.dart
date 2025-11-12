import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/enums/service_role.dart';

String getRightRoute({required ServiceRole role}) {
  switch (role) {
    case ServiceRole.resident:
      return AppRoutes.residenBottomNavBar;
    case ServiceRole.driver:
      return AppRoutes.residentInfoScreen;

    case ServiceRole.doctor:
      return AppRoutes.residenBottomNavBar;

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
