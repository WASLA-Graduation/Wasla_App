import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/database/api/api_keys.dart';
import 'package:wasla/core/database/cache/shared_preferences_helper.dart';
import 'package:wasla/core/enums/service_role.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/functions/get_user_id.dart';
import 'package:wasla/core/service/service_locator.dart';
import 'package:wasla/features/reviews/presentation/manager/cubit/reviews_cubit.dart';

enum NotificatonsRoutes {
  splashScreen, // 0
  onboardingScreen, // 1
  signInScreen, // 2
  signUpScreen, // 3
  resetPassScreen, // 4
  verifyScreen, // 5
  forgotScreen, // 6
  residentInfoScreen, // 7
  doctorInfoScreen, // 8
  doctorCompleteInfoScreen, // 9
  resturentInfoScreen, // 10
  authMapScreen, // 11
  residentHomeScreen, // 12
  residenBottomNavBar, // 13
  allServicesScreen, // 14
  residentSearchScreen, // 15
  doctorScreen, // 16
  doctorDetailsScreen, // 17
  chnageLangScreen, // 18
  residentEditProfileScreen, // 19
  accountChangePassScreen, // 20
  doctorNavbarScreen, // 21
  doctorAddServiceScreen, // 22
  reviewScreen, // 23
  doctorSeeSevicesScreen, // 24
  doctorBookingScreen, // 25
  doctorEditBookingScreen, // 26
  doctorEditProfileScreen, // 27
  allFavouritesScreen, // 28
  residentPersonalInfoScreen, // 29
  residentBookingScreen, // 30
  gymCompleteInfoScreen, // 31
  gymDashbaordScreen, // 32
  gymBottomNavBarScreen, // 33
  gymAddUpdatePackageScreen, // 34
  residentProfileInfoScreen, // 35
  doctorProfileInfoScreen, // 36
  gymProfileInfoScreen, // 37
  gymEditProfileScreen, // 38
  gymResidentScreen, // 39
  gymResidentDetailsScreen, // 40
  gymResidentSeePackagesScreen, // 41
  gymScanQrScreen, // 42
  notificationsScreen, // 43;
  paymentSuccessScreen, // 44;
  paymentFailureScreen, // 45;
  newRideRequest, // 46
  rideAccepted, // 47
  rideCancelled, // 48
  rideCompleted; // 49

  static NotificatonsRoutes fromInt(int index) {
    return NotificatonsRoutes.values[index];
  }
}

void navigateToRightRoute({
  required NotificatonsRoutes route,
  required String refereceId,
}) async {
  switch (route) {
    case NotificatonsRoutes.splashScreen: //0
      // TODO: Handle this case.
      throw UnimplementedError();
    case NotificatonsRoutes.onboardingScreen: //1
      // TODO: Handle this case.
      throw UnimplementedError();
    case NotificatonsRoutes.signInScreen: //2
      // TODO: Handle this case.
      throw UnimplementedError();
    case NotificatonsRoutes.signUpScreen: //3
      // TODO: Handle this case.
      throw UnimplementedError();
    case NotificatonsRoutes.resetPassScreen: //4
      // TODO: Handle this case.
      throw UnimplementedError();
    case NotificatonsRoutes.verifyScreen: //5
      // TODO: Handle this case.
      throw UnimplementedError();
    case NotificatonsRoutes.forgotScreen: //6
      // TODO: Handle this case.
      throw UnimplementedError();
    case NotificatonsRoutes.residentInfoScreen: //7
      // TODO: Handle this case.
      throw UnimplementedError();
    case NotificatonsRoutes.doctorInfoScreen: //8
      // TODO: Handle this case.
      throw UnimplementedError();
    case NotificatonsRoutes.doctorCompleteInfoScreen: //9
      // TODO: Handle this case.
      throw UnimplementedError();
    case NotificatonsRoutes.resturentInfoScreen: //10
      // TODO: Handle this case.
      throw UnimplementedError();
    case NotificatonsRoutes.authMapScreen: //11
      // TODO: Handle this case.
      throw UnimplementedError();
    case NotificatonsRoutes.residentHomeScreen: //12
      // TODO: Handle this case.
      throw UnimplementedError();
    case NotificatonsRoutes.residenBottomNavBar: //13
      // TODO: Handle this case.
      throw UnimplementedError();
    case NotificatonsRoutes.allServicesScreen: //14
      // TODO: Handle this case.
      throw UnimplementedError();
    case NotificatonsRoutes.residentSearchScreen: //15
      // TODO: Handle this case.
      throw UnimplementedError();
    case NotificatonsRoutes.doctorScreen: //16
      // TODO: Handle this case.
      throw UnimplementedError();
    case NotificatonsRoutes.doctorDetailsScreen: //17
      // TODO: Handle this case.
      throw UnimplementedError();
    case NotificatonsRoutes.chnageLangScreen: //18
      // TODO: Handle this case.
      throw UnimplementedError();
    case NotificatonsRoutes.residentEditProfileScreen: //19
      // TODO: Handle this case.
      throw UnimplementedError();
    case NotificatonsRoutes.accountChangePassScreen: //20
      // TODO: Handle this case.
      throw UnimplementedError();
    case NotificatonsRoutes.doctorNavbarScreen:
      // TODO: Handle this case.
      throw UnimplementedError();
    case NotificatonsRoutes.doctorAddServiceScreen:
      // TODO: Handle this case.
      throw UnimplementedError();
    case NotificatonsRoutes.reviewScreen:
      final reviewId = int.parse(refereceId);
      final String? userId = await getUserId();
      final cubit = navigatorKey.currentContext?.read<ReviewsCubit>();
      cubit?.resetState();
      cubit?.getReveiws(userId!);
      cubit?.selectedUserId = userId;
      navigatorKey.currentContext!.push(
        AppRoutes.reviewScreen,
        extra: reviewId,
      );
      break;

    case NotificatonsRoutes.doctorSeeSevicesScreen:
      navigatorKey.currentContext!.push(
        AppRoutes.doctorSeeSevicesScreen,
        extra: refereceId,
      );
      break;
    case NotificatonsRoutes.doctorBookingScreen:
      // TODO: Handle this case.
      throw UnimplementedError();
    case NotificatonsRoutes.doctorEditBookingScreen:
      // TODO: Handle this case.
      throw UnimplementedError();
    case NotificatonsRoutes.doctorEditProfileScreen:
      // TODO: Handle this case.
      throw UnimplementedError();
    case NotificatonsRoutes.allFavouritesScreen:
      // TODO: Handle this case.
      throw UnimplementedError();
    case NotificatonsRoutes.residentPersonalInfoScreen:
      // TODO: Handle this case.
      throw UnimplementedError();
    case NotificatonsRoutes.residentBookingScreen:
      // TODO: Handle this case.
      throw UnimplementedError();
    case NotificatonsRoutes.gymCompleteInfoScreen:
      // TODO: Handle this case.
      throw UnimplementedError();
    case NotificatonsRoutes.gymDashbaordScreen:
      // TODO: Handle this case.
      throw UnimplementedError();
    case NotificatonsRoutes.gymBottomNavBarScreen:
      // TODO: Handle this case.
      throw UnimplementedError();
    case NotificatonsRoutes.gymAddUpdatePackageScreen:
      // TODO: Handle this case.
      throw UnimplementedError();
    case NotificatonsRoutes.residentProfileInfoScreen:
      // TODO: Handle this case.
      throw UnimplementedError();
    case NotificatonsRoutes.doctorProfileInfoScreen:
      // TODO: Handle this case.
      throw UnimplementedError();
    case NotificatonsRoutes.gymProfileInfoScreen:
      // TODO: Handle this case.
      throw UnimplementedError();
    case NotificatonsRoutes.gymEditProfileScreen:
      // TODO: Handle this case.
      throw UnimplementedError();
    case NotificatonsRoutes.gymResidentScreen:
      // TODO: Handle this case.
      throw UnimplementedError();
    case NotificatonsRoutes.gymResidentDetailsScreen:
      // TODO: Handle this case.
      throw UnimplementedError();
    case NotificatonsRoutes.gymResidentSeePackagesScreen:
      navigatorKey.currentContext!.push(
        AppRoutes.gymResidentSeePackagesScreen,
        extra: refereceId,
      );
      break;
    case NotificatonsRoutes.gymScanQrScreen:
      // TODO: Handle this case.
      throw UnimplementedError();
    case NotificatonsRoutes.notificationsScreen:
      // TODO: Handle this case.
      throw UnimplementedError();
    case NotificatonsRoutes.paymentSuccessScreen:
      navigatorKey.currentContext!.push(
        AppRoutes.paymentSuccessScreen,
        extra: refereceId,
      );
      break;

    case NotificatonsRoutes.paymentFailureScreen:
      navigatorKey.currentContext!.push(
        AppRoutes.paymentFailureScreen,
        extra: refereceId,
      );
    case NotificatonsRoutes.newRideRequest:
      final tripId = int.parse(refereceId);
      navigatorKey.currentContext!.push(
        AppRoutes.suggestedTripScreen,
        extra: tripId,
      );
      break;
    case NotificatonsRoutes.rideAccepted:
      return;
    case NotificatonsRoutes.rideCancelled:
      final String? currentRole = await SharedPreferencesHelper.get(
        key: ApiKeys.role,
      );

      final bool isDriver = currentRole == ServiceRole.driver.name;
      navigatorKey.currentContext!.push(
        AppRoutes.tripCanceldScreen,
        extra: isDriver,
      );
      break;

    case NotificatonsRoutes.rideCompleted:
      navigatorKey.currentContext!.push(
        AppRoutes.driverReviewScreen,
        extra: refereceId,
      );
      break;
  }
}

void navigateToRouteRealTime({required RemoteMessage message}) async {
  final int route = int.parse(message.data['type']);
  // final String refrenceId = message.data['refrenceId'];
  switch (route) {
    case 48:
      final String? currentRole = await SharedPreferencesHelper.get(
        key: ApiKeys.role,
      );

      final bool isDriver = currentRole == ServiceRole.driver.name;
      navigatorKey.currentContext!.pushAndRemoveAllScreens(
        AppRoutes.tripCanceldScreen,
        arguments: isDriver,
      );
      break;
    case 47:
      final tripId = int.parse(message.data['refrenceId']);
      navigatorKey.currentContext!.pushReplacement(
        AppRoutes.driverTripDetailsScreen,
        extra: tripId,
      );
      break;
  }
}
