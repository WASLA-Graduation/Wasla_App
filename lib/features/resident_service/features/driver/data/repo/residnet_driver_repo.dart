import 'package:dartz/dartz.dart';
import 'package:latlong2/latlong.dart';
import 'package:wasla/features/resident_service/features/driver/data/models/resident_trip_model.dart';

abstract class ResidnetDriverRepo {
  // Future<Either<String, LatLng>> getDriverLocation({required LatLng user});
  Future<Either<String, LatLng>> getDriverLocation({required String driverId});
  Future<Either<String, int>> searchToRide({
    required String passengerId,
    required double pickupLatitude,
    required double pickupLongitude,
    required double dropoffLatitude,
    required double dropoffLongitude,
    required String pickUpPlace,
    required String dropOffPlace,
    required int vehicleType,
  });

  Future<Either<String, Null>> cancelRide({
    required int tripId,
    required bool isResident,
  });
  Future<Either<String, ResidentTripModel>> getTripForResident({
    required int tripId,
  });
  Future<Either<String, Null>> rateDriver({
    required String driverId,
    required int starts,
  });
}
