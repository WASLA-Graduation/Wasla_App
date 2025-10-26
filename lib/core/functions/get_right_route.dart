import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/enums/service_role.dart';

String getRightRoute({required ServiceRole role}) {
  switch (role) {
    case ServiceRole.resident:
      return AppRoutes.residentInfoScreen;
    case ServiceRole.driver:
      return AppRoutes.residentInfoScreen;

    case ServiceRole.doctor:
      return AppRoutes.residentInfoScreen;

    case ServiceRole.technician:
      return AppRoutes.residentInfoScreen;

    case ServiceRole.restaurantOwner:
      return AppRoutes.residentInfoScreen;

    case ServiceRole.gymOwner:
      return AppRoutes.residentInfoScreen;
  }
}
