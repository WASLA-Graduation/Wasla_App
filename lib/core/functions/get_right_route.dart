import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/database/api/api_keys.dart';
import 'package:wasla/core/database/cache/shared_preferences_helper.dart';
import 'package:wasla/core/enums/service_role.dart';
import 'package:wasla/core/extensions/service_role_extension.dart';
import 'package:wasla/features/doctor_service/features/home/presentation/manager/cubit/doctor_home_cubit.dart';
import 'package:wasla/features/driver/features/home/presentation/manager/cubit/driver_cubit.dart';
import 'package:wasla/features/gym/features/dashboard/presentation/manager/cubit/gym_dashboard_cubit.dart';
import 'package:wasla/features/resident_service/features/home/presentation/manager/cubit/home_resident_cubit.dart';
import 'package:wasla/features/technicant/features/home/presentation/manager/cubit/technicant_dashboard_cubit.dart';

String getRightRoute({required ServiceRole role}) {
  switch (role) {
    case ServiceRole.resident:
      return AppRoutes.residenBottomNavBar;
    case ServiceRole.driver:
      return AppRoutes.driverBottomNavBarScreen;

    case ServiceRole.doctor:
      return AppRoutes.doctorNavbarScreen;

    case ServiceRole.technician:
      return AppRoutes.technicantBottomNavBarScreen;

    case ServiceRole.restaurantOwner:
      return AppRoutes.restuarantBottomNavBar;

    case ServiceRole.gymOwner:
      return AppRoutes.gymBottomNavBarScreen;
  }
}

String getRightCompleteServiceRoute({required ServiceRole role}) {
  switch (role) {
    case ServiceRole.resident:
      return AppRoutes.residentInfoScreen;
    case ServiceRole.driver:
      return AppRoutes.driverCompleteInfoScreen;

    case ServiceRole.doctor:
      return AppRoutes.doctorInfoScreen;

    case ServiceRole.technician:
      return AppRoutes.technicantCompleteInfoScreen;

    case ServiceRole.restaurantOwner:
      return AppRoutes.restuarantCompleteInfo;

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
      return AppRoutes.driverEditProfileScreen;

    case ServiceRole.doctor:
      return AppRoutes.doctorEditProfileScreen;

    case ServiceRole.technician:
      return AppRoutes.technicantEditProfileScreen;

    case ServiceRole.restaurantOwner:
      return AppRoutes.restuarantEditProfile;

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
      return AppRoutes.driverProfileInfoScreen;

    case ServiceRole.doctor:
      return AppRoutes.doctorProfileInfoScreen;

    case ServiceRole.technician:
      return AppRoutes.technicantInfoScreen;

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
      break;
    case ServiceRole.driver:
      context.read<DriverCubit>().bottomNabBarIndex = 0;
      break;

    case ServiceRole.doctor:
      context.read<DoctorHomeCubit>().navBarCurrentIndex = 0;
      break;

    case ServiceRole.technician:
      context.read<TechnicantDashboardCubit>().bottomNabBarIndex = 0;
      break;

    case ServiceRole.restaurantOwner:
      AppRoutes.residentEditProfileScreen;

    case ServiceRole.gymOwner:
      context.read<GymDashboardCubit>().bottomNavBarcurrentIndex = 0;
      break;
  }
}
