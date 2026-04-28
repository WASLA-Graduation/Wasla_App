import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:wasla/core/enums/driver_status.dart';
import 'package:wasla/core/error/failure.dart';
import 'package:wasla/core/functions/get_user_id.dart';
import 'package:wasla/core/functions/toast_alert.dart';
import 'package:wasla/core/service/maps/map_services.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/features/driver/features/trip/data/models/driver_trip_and_resident_info_model.dart';
import 'package:wasla/features/driver/features/trip/data/repo/driver_trip_repo.dart';

part 'driver_trip_state.dart';

class DriverTripCubit extends Cubit<DriverTripState> {
  DriverTripCubit(this.driverTripRepo) : super(DriverTripInitial());

  final DriverTripRepo driverTripRepo;
  final mapController = MapController();

  LatLng passengerLocation = LatLng(30.0770, 31.3400);
  LatLng? driverLocation;

  List<LatLng> routePoints = [];
  double driverRotation = 0.0;

  Timer? liveTrackingTimer;
  bool isDriverArrived = false;
  bool isStartedTrip = false;
  int tripId = -1;
  int tripIdStored = -1;

  final Distance distance = const Distance();
  Timer? driverLocationTimer;
  TripModel? tripDetails;

  void onRetry() {
    emit(DriverTripOnRetryState());
  }

  Future<void> fetchDriverLocation() async {
    final result = await MapServices.getCurrentLocation();
    result.fold((error) {}, (location) {
      driverLocation = LatLng(location.latitude!, location.longitude!);
    });
  }

  Future<void> initializeTrip() async {
    await fetchDriverLocation();
    if (driverLocation != null) {
      routePoints = await MapServices.getBestRoute(
        start: driverLocation!,
        end: passengerLocation,
      );
    }
    emit(DriverChangeMyLocation());
  }

  Future<void> recalculateRoute() async {
    if (driverLocation != null) {
      routePoints = await MapServices.getBestRoute(
        start: driverLocation!,
        end: passengerLocation,
      );
    }
  }

  bool isDriverOffRoute() {
    if (routePoints.isEmpty || driverLocation == null) return false;

    double minDistance = double.infinity;
    for (final point in routePoints) {
      final d = distance.as(LengthUnit.Meter, driverLocation!, point);
      if (d < minDistance) minDistance = d;
    }
    return minDistance > 50;
  }

  void updateDriverRotation() {
    if (routePoints.length < 2) return;

    driverRotation = MapServices.calculateBearing(
      routePoints.first,
      routePoints[1],
    );
  }

  void checkArrival() {
    if (driverLocation == null) return;

    final d = distance.as(LengthUnit.Meter, driverLocation!, passengerLocation);
    if (d < 10) {
      isDriverArrived = true;
      stopLiveTracking();
      emit(DriverWhenArrived());
    }
  }

  void startLiveTracking() {
    liveTrackingTimer?.cancel();

    liveTrackingTimer = Timer.periodic(const Duration(seconds: 2), (
      timer,
    ) async {
      if (isDriverArrived) {
        timer.cancel();
        return;
      }

      await fetchDriverLocation();

      if (driverLocation != null) {
        routePoints = await MapServices.getBestRoute(
          start: driverLocation!,
          end: passengerLocation,
        );
      }

      updateDriverRotation();
      checkArrival();

      emit(DriverChangeMyLocation());
    });
  }

  void stopLiveTracking() {
    liveTrackingTimer?.cancel();
  }

  void backToOriginalLocation() {
    if (driverLocation != null) {
      mapController.move(driverLocation!, 12);
      emit(DriverBackToMyLocation());
    }
  }

  Future<void> cancelRide() async {
    emit(DriverCancelRideLoading());
    final result = await driverTripRepo.cancelRide(
      tripId: tripId,
      isResident: false,
    );
    result.fold((error) => emit(DriverCancelRideFailure(errorMessage: error)), (
      success,
    ) {
      tripId = -1;
      tripIdStored = -1;
      emit(DriverCancelRideSuccess());
    });
  }

  Future<void> startRide() async {
    emit(DriverStartRideLoading());
    final result = await driverTripRepo.startRide(id: tripId);
    result.fold((error) => emit(DriverStartRideFailure(errorMessage: error)), (
      success,
    ) {
      isStartedTrip = true;
      tripId = -1;
      emit(DriverStrartRideSuccess());
    });
  }

  Future<void> compelteRide() async {
    emit(DriverCompleteRideLoading());
    final result = await driverTripRepo.completeRide(id: tripIdStored);
    result.fold(
      (error) => emit(DriverCompleteRideFailure(errorMessage: error)),
      (success) {
        isStartedTrip = false;
        tripIdStored = -1;
        tripId = -1;
        emit(DriverCompleteRideSuccess());
      },
    );
  }

  Future<void> acceptRide() async {
    final String? driverId = await getUserId();
    emit(DriverAcceptRideLoading());
    final result = await driverTripRepo.acceptRide(
      id: tripId,
      driverId: driverId!,
    );
    result.fold(
      (error) => emit(DriverAcceptRideFailure(errorMessage: error)),
      (success) => emit(DriverAcceptRideSuccess()),
    );
  }

  Future<void> updateDriverLocation() async {
    await fetchDriverLocation();

    final String? driverId = await getUserId();
    if (driverId == null) return;
    final result = await driverTripRepo.updateDriverLocation(
      driverId: driverId,
      location: driverLocation!,
    );
    result.fold((error) {}, (success) {});
  }

  void sendDriverLocatonToBackEnd() {
    driverLocationTimer?.cancel();

    if (tripId == -1) {
      driverLocationTimer = Timer.periodic(const Duration(seconds: 10), (
        timer,
      ) {
        if (tripId == -1) {
          updateDriverLocation();
        } else {
          timer.cancel();
          sendDriverLocatonToBackEnd();
        }
      });
    } else {
      driverLocationTimer = Timer.periodic(const Duration(milliseconds: 1500), (
        timer,
      ) {
        if (tripId != -1) {
          updateDriverLocation();
        } else {
          timer.cancel();
          sendDriverLocatonToBackEnd();
        }
      });
    }
  }

  void stopDriverLocationTimer({required String driverId}) async {
    driverLocationTimer?.cancel();
    driverLocationTimer = null;

    await driverTripRepo.updateDriverStatus(
      driverId: driverId,
      status: DriverStatus.offline,
    );
  }

  Future<void> updateDriverStatus({required DriverStatus driverStatus}) async {
    final String? driverId = await getUserId();
    final result = await driverTripRepo.updateDriverStatus(
      driverId: driverId!,
      status: driverStatus,
    );
    result.fold(
      (error) => toastAlert(color: AppColors.red, msg: 'Restart the app'),
      (success) {},
    );
  }

  Future<void> getRideDetails() async {
    emit(DriverGetRideDeatialsLoading());
    final result = await driverTripRepo.getTripDetails(tripId: tripId);
    result.fold(
      (error) {
        if (error is NoInternetFailure) {
          emit(DriverTripNetworkState());
        } else {
          emit(DriverTripFailureState());
        }
      },
      (success) {
        tripDetails = success;
        emit(DriverGetRideDeatialsSuccess());
      },
    );
  }
}
