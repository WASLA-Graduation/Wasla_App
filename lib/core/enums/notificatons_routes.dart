import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/database/api/api_keys.dart';
import 'package:wasla/core/database/cache/shared_preferences_helper.dart';
import 'package:wasla/core/enums/booking_filter.dart';
import 'package:wasla/core/enums/service_role.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/functions/get_user_id.dart';
import 'package:wasla/core/service/service_locator.dart';
import 'package:wasla/core/utils/app_strings.dart';
import 'package:wasla/features/resident_service/features/booking/presentation/manager/cubit/resident_booking_cubit.dart';
import 'package:wasla/features/resident_service/features/driver/presentation/manager/cubit/resident_driver_cubit.dart';
import 'package:wasla/features/resident_service/features/home/presentation/manager/cubit/home_resident_cubit.dart';
import 'package:wasla/features/restaurant/home/presentation/manager/cubit/restaurant_dashboard_cubit.dart';
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
  postReacted, // 25
  residentCancelDoctorBooking, // 26
  restaurantReservationAccepted, //27
  restaurantNewReservation, //28
  orderStartedPreparing, //29
  socialHidden, //30
  orderCancelled; //31

  static NotificationRoute fromInt(int index) {
    return NotificationRoute.values[index];
  }
}

void navigateToRightRoute({
  required String image,
  required String name,
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
        extra: {'fromGym': true, 'qr': referenceId},
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
      return;
    case NotificationRoute.doctorBookingScreen:
      navigatorKey.currentContext!.pushAndRemoveAllScreens(
        AppRoutes.doctorNavbarScreen,
      );

      break;

    case NotificationRoute.doctorEditBookingScreen:
      final cubit = navigatorKey.currentContext!.read<HomeResidentCubit>();
      cubit.updateNavBarCurrentIndex(1);
      navigatorKey.currentContext!.pushAndRemoveAllScreens(
        AppRoutes.residenBottomNavBar,
      );
      break;

    case NotificationRoute.doctorCancelBookingScreen:
      final cubit = navigatorKey.currentContext!.read<HomeResidentCubit>();

      cubit.updateNavBarCurrentIndex(1);

      navigatorKey.currentContext!.pushAndRemoveAllScreens(
        AppRoutes.residenBottomNavBar,
      );
      break;

    case NotificationRoute.messageReceived:
      log(referenceId);
      break;

    case NotificationRoute.driverCompleteInfoScreen:
      return;

    case NotificationRoute.gymCompleteInfoScreen:
      return;

    case NotificationRoute.gymPackageBooked:
      navigatorKey.currentContext!.pushAndRemoveAllScreens(
        AppRoutes.gymBottomNavBarScreen,
      );
      break;

    case NotificationRoute.gymPackageExpired:
      final cubit = navigatorKey.currentContext!.read<HomeResidentCubit>();
      final bookingCubit = navigatorKey.currentContext!
          .read<ResidentBookingCubit>();
      cubit.updateNavBarCurrentIndex(1);

      bookingCubit.updateBookingTaps(bookingFilter: BookingFilter.gymBookings);
      navigatorKey.currentContext!.pushAndRemoveAllScreens(
        AppRoutes.residenBottomNavBar,
      );
      break;

    case NotificationRoute.gymBookingCancelled:
      final String? currentRole = await SharedPreferencesHelper.get(
        key: ApiKeys.role,
      );
      final bool isResident = currentRole == ServiceRole.resident.name;

      if (!isResident) {
        navigatorKey.currentContext!.pushAndRemoveAllScreens(
          AppRoutes.gymBottomNavBarScreen,
        );
        break;
      } else {
        final cubit = navigatorKey.currentContext!.read<HomeResidentCubit>();
        final bookingCubit = navigatorKey.currentContext!
            .read<ResidentBookingCubit>();
        cubit.updateNavBarCurrentIndex(1);

        bookingCubit.updateBookingTaps(
          bookingFilter: BookingFilter.gymBookings,
        );
        navigatorKey.currentContext!.pushAndRemoveAllScreens(
          AppRoutes.residenBottomNavBar,
        );
        break;
      }

    case NotificationRoute.residentCompleteInfoScreen:
      return;

    case NotificationRoute.technicianCompleteInfoScreen:
      return;
    case NotificationRoute.technicianAcceptBooking:
      final cubit = navigatorKey.currentContext!.read<HomeResidentCubit>();
      final bookingCubit = navigatorKey.currentContext!
          .read<ResidentBookingCubit>();
      cubit.updateNavBarCurrentIndex(1);

      bookingCubit.updateBookingTaps(
        bookingFilter: BookingFilter.technicianBookings,
      );
      navigatorKey.currentContext!.pushAndRemoveAllScreens(
        AppRoutes.residenBottomNavBar,
      );
      break;

    case NotificationRoute.technicianRejectBooking:
      final cubit = navigatorKey.currentContext!.read<HomeResidentCubit>();
      final bookingCubit = navigatorKey.currentContext!
          .read<ResidentBookingCubit>();
      cubit.updateNavBarCurrentIndex(1);

      bookingCubit.updateBookingTaps(
        bookingFilter: BookingFilter.technicianBookings,
      );
      navigatorKey.currentContext!.pushAndRemoveAllScreens(
        AppRoutes.residenBottomNavBar,
      );
      break;

    case NotificationRoute.userTechnicianBookingCancelled:
      final int bookingId = int.parse(referenceId);
      navigatorKey.currentContext!.push(
        AppRoutes.technicianBookingDetailsScreen,
        extra: bookingId,
      );
      break;

    case NotificationRoute.technicianCancelBooking:
      final cubit = navigatorKey.currentContext!.read<HomeResidentCubit>();
      final bookingCubit = navigatorKey.currentContext!
          .read<ResidentBookingCubit>();
      cubit.updateNavBarCurrentIndex(1);

      bookingCubit.updateBookingTaps(
        bookingFilter: BookingFilter.technicianBookings,
      );
      navigatorKey.currentContext!.pushAndRemoveAllScreens(
        AppRoutes.residenBottomNavBar,
      );
      break;

    case NotificationRoute.postCommented:
      final cubit = navigatorKey.currentContext!.read<HomeResidentCubit>();
      if (cubit.user != null) {
        final String? userId = await getUserId();
        navigatorKey.currentContext!.pushScreen(
          AppRoutes.socialProfileScreen,
          arguments: {
            AppStrings.name: cubit.user!.fullName,
            AppStrings.id: userId,
          },
        );
      }
      break;

    case NotificationRoute.postReacted:
      final cubit = navigatorKey.currentContext!.read<HomeResidentCubit>();
      if (cubit.user != null) {
        final String? userId = await getUserId();
        navigatorKey.currentContext!.pushScreen(
          AppRoutes.socialProfileScreen,
          arguments: {
            AppStrings.name: cubit.user!.fullName,
            AppStrings.id: userId,
          },
        );
      }
      break;
    case NotificationRoute.residentCancelDoctorBooking:
      navigatorKey.currentContext!.pushAndRemoveAllScreens(
        AppRoutes.doctorNavbarScreen,
      );
      break;

    case NotificationRoute.restaurantReservationAccepted:
      navigatorKey.currentContext!.push(
        AppRoutes.paymentSuccessScreen,
        extra: {'fromGym': false, 'qr': referenceId},
      );
      break;
    case NotificationRoute.restaurantNewReservation:
      final cubit = navigatorKey.currentContext!
          .read<RestaurantDashboardCubit>();

      cubit.updateBottomNavBarIndex(2);
      navigatorKey.currentContext!.pushAndRemoveAllScreens(
        AppRoutes.restuarantBottomNavBar,
      );
      break;
    case NotificationRoute.orderStartedPreparing:
      navigatorKey.currentContext!.push(
        AppRoutes.residentRestaurantOrdersScreen,
      );
      break;
    case NotificationRoute.socialHidden:
      return;
    case NotificationRoute.orderCancelled:
      navigatorKey.currentContext!.push(
        AppRoutes.residentRestaurantOrdersScreen,
      );
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
      navigatorKey.currentContext!
          .read<ResidentDriverCubit>()
          .cancelTripTimer
          ?.cancel();
      navigatorKey.currentContext!.pushReplacement(
        AppRoutes.driverTripDetailsScreen,
        extra: tripId,
      );
      break;

    default:
      break;
  }
}
