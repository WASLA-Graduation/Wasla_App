import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/database/api/api_keys.dart';
import 'package:wasla/core/database/cache/shared_preferences_helper.dart';
import 'package:wasla/core/enums/service_role.dart';
import 'package:wasla/core/extensions/service_role_extension.dart';
import 'package:wasla/features/doctor_service/features/home/presentation/manager/cubit/doctor_home_cubit.dart';
import 'package:wasla/features/resident_service/features/home/presentation/manager/cubit/home_resident_cubit.dart';

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
      return AppRoutes.gymBottomNavBarScreen;
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
      return AppRoutes.gymCompleteInfoScreen;
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
      return AppRoutes.doctorEditProfileScreen;

    case ServiceRole.technician:
      return AppRoutes.residentEditProfileScreen;

    case ServiceRole.restaurantOwner:
      return AppRoutes.residentEditProfileScreen;

    case ServiceRole.gymOwner:
      return AppRoutes.gymEditProfileScreen;
  }
}

String getRightPersonalInfoRoute() {
  final String? role = SharedPreferencesHelper.get(key: ApiKeys.role);
  switch (ServiceRoleExtension.fromString(role!)) {
    case ServiceRole.resident:
      return AppRoutes.residentPersonalInfoScreen;
    case ServiceRole.driver:
      return AppRoutes.residentPersonalInfoScreen;

    case ServiceRole.doctor:
      return AppRoutes.doctorProfileInfoScreen;

    case ServiceRole.technician:
      return AppRoutes.residentPersonalInfoScreen;

    case ServiceRole.restaurantOwner:
      return AppRoutes.residentPersonalInfoScreen;

    case ServiceRole.gymOwner:
      return AppRoutes.gymProfileInfoScreen;
  }
}

void resetDataInSpecificRole(BuildContext context) {
  final String? role = SharedPreferencesHelper.get(key: ApiKeys.role);
  switch (ServiceRoleExtension.fromString(role!)) {
    case ServiceRole.resident:
      context.read<HomeResidentCubit>().navBarcurrentIndex = 0;
    case ServiceRole.driver:
      AppRoutes.residentEditProfileScreen;

    case ServiceRole.doctor:
      context.read<DoctorHomeCubit>().navBarCurrentIndex = 0;

    case ServiceRole.technician:
      AppRoutes.residentEditProfileScreen;

    case ServiceRole.restaurantOwner:
      AppRoutes.residentEditProfileScreen;

    case ServiceRole.gymOwner:
      AppRoutes.residentEditProfileScreen;
  }
}
