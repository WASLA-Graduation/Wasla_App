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

enum NotificationRoute {
  reviewScreen, // 0
  gymPaymentSuccess, // 1
  gymPaymentFailed, // 2
  newRideRequest, // 3
  rideAccepted, // 4
  rideCancelled, // 5
  rideCompleted, // 6
  technicianNewBookingRequest, // 7
  doctorCompleteInfoScreen, // 8
  doctorBookingScreen, // 9
  doctorEditBookingScreen, // 10
  doctorCancelBookingScreen, // 11
  messageReceived, // 12
  driverCompleteInfoScreen, // 13
  gymCompleteInfoScreen, // 14
  gymPackageBooked, // 15
  gymPackageExpired, // 16
  gymBookingCancelled, // 17
  residentCompleteInfoScreen, // 18
  technicianCompleteInfoScreen, // 19
  technicianAcceptBooking, // 20
  technicianRejectBooking, // 21
  userTechnicianBookingCancelled, // 22
  technicianCancelBooking, // 23
  postCommented, // 24
  postReacted; // 25

  static NotificationRoute fromInt(int index) {
    return NotificationRoute.values[index];
  }
}

void navigateToRightRoute({
  required NotificationRoute route,
  required String referenceId,
}) async {
  switch (route) {
    case NotificationRoute.reviewScreen:
      final reviewId = int.parse(referenceId);
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

    case NotificationRoute.gymPaymentSuccess:
      navigatorKey.currentContext!.push(
        AppRoutes.paymentSuccessScreen,
        extra: referenceId,
      );
      break;

    case NotificationRoute.gymPaymentFailed:
      navigatorKey.currentContext!.push(
        AppRoutes.paymentFailureScreen,
        extra: referenceId,
      );
      break;

    case NotificationRoute.newRideRequest:
      final tripId = int.parse(referenceId);
      navigatorKey.currentContext!.push(
        AppRoutes.suggestedTripScreen,
        extra: tripId,
      );
      break;

    case NotificationRoute.rideAccepted:
      return;

    case NotificationRoute.rideCancelled:
      final String? currentRole = await SharedPreferencesHelper.get(
        key: ApiKeys.role,
      );
      final bool isDriver = currentRole == ServiceRole.driver.name;
      navigatorKey.currentContext!.push(
        AppRoutes.tripCanceldScreen,
        extra: isDriver,
      );
      break;

    case NotificationRoute.rideCompleted:
      navigatorKey.currentContext!.push(
        AppRoutes.driverReviewScreen,
        extra: referenceId,
      );
      break;

    case NotificationRoute.technicianNewBookingRequest:
      final int bookingId = int.parse(referenceId);
      navigatorKey.currentContext!.push(
        AppRoutes.technicianBookingDetailsScreen,
        extra: bookingId,
      );
      break;

    case NotificationRoute.doctorCompleteInfoScreen:
      // TODO: implement
      break;

    case NotificationRoute.doctorBookingScreen:
      // TODO: implement
      break;

    case NotificationRoute.doctorEditBookingScreen:
      // TODO: implement
      break;

    case NotificationRoute.doctorCancelBookingScreen:
      // TODO: implement
      break;

    case NotificationRoute.messageReceived:
      // TODO: implement
      break;

    case NotificationRoute.driverCompleteInfoScreen:
      // TODO: implement
      break;

    case NotificationRoute.gymCompleteInfoScreen:
      // TODO: implement
      break;

    case NotificationRoute.gymPackageBooked:
      navigatorKey.currentContext!.push(
        AppRoutes.gymResidentSeePackagesScreen,
        extra: referenceId,
      );
      break;

    case NotificationRoute.gymPackageExpired:
      // TODO: implement
      break;

    case NotificationRoute.gymBookingCancelled:
      // TODO: implement
      break;

    case NotificationRoute.residentCompleteInfoScreen:
      // TODO: implement
      break;

    case NotificationRoute.technicianCompleteInfoScreen:
      // TODO: implement
      break;

    case NotificationRoute.technicianAcceptBooking:
      // TODO: implement
      break;

    case NotificationRoute.technicianRejectBooking:
      // TODO: implement
      break;

    case NotificationRoute.userTechnicianBookingCancelled:
      // TODO: implement
      break;

    case NotificationRoute.technicianCancelBooking:
      // TODO: implement
      break;

    case NotificationRoute.postCommented:
      // TODO: implement
      break;

    case NotificationRoute.postReacted:
      // TODO: implement
      break;
  }
}

void navigateToRouteRealTime({required RemoteMessage message}) async {
  final int routeIndex = int.parse(message.data['type']);
  final route = NotificationRoute.fromInt(routeIndex);

  switch (route) {
    case NotificationRoute.rideCancelled:
      final String? currentRole = await SharedPreferencesHelper.get(
        key: ApiKeys.role,
      );
      final bool isDriver = currentRole == ServiceRole.driver.name;
      navigatorKey.currentContext!.pushAndRemoveAllScreens(
        AppRoutes.tripCanceldScreen,
        arguments: isDriver,
      );
      break;

    case NotificationRoute.rideAccepted:
      final tripId = int.parse(message.data['refrenceId']);
      navigatorKey.currentContext!.pushReplacement(
        AppRoutes.driverTripDetailsScreen,
        extra: tripId,
      );
      break;

    default:
      break;
  }
}
