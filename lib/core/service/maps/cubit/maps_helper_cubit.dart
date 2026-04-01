import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart' hide Location;
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
part 'maps_helper_state.dart';

class MapsHelperCubit extends Cubit<MapsHelperState> {
  MapsHelperCubit() : super(MapsHelperInitial());

  double lat = 30.0444;
  double long = 31.2357;
  double mapZoom = 10.0;
  LatLng? orignalLocation;
  String locationAddress = '';
  final mapController = MapController();

  void updateMapZoomIn() {
    ++mapZoom;
    mapController.move(LatLng(lat, long), mapZoom);
    emit(MapsHelperInitial());
  }

  void updateMapZoomOut() {
    --mapZoom;
    mapController.move(LatLng(lat, long), mapZoom);
    emit(MapsHelperInitial());
  }

  void updateMapLocation({required double lat, required double long}) {
    this.lat = lat;
    this.long = long;
    emit(MapsHelperUpdateMapLocation());
  }

  void backToOriginalLocation() {
    lat = orignalLocation!.latitude;
    long = orignalLocation!.longitude;
    emit(MapsHelperBackToOriginalLocation());
  }

  Future<void> getCurrentLocation() async {
    emit(MapsHelperGetLocationLoading());
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        emit(
          MapsHelperGetLocationError(
            message: "Location service is disabled,please enable it",
          ),
        );
        return;
      }
    }
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        emit(
          MapsHelperGetLocationError(message: "Location permission is denied"),
        );
        return;
      }
    }
    locationData = await location.getLocation();
    lat = locationData.latitude!;
    long = locationData.longitude!;
    orignalLocation = LatLng(lat, long);
    emit(MapsHelperGetLocationSuccess());
  }

  Future<void> getAddressFromLatLng(double lat, double lng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
      Placemark place = placemarks.first;

      locationAddress = '${place.street}, ${place.locality}, ${place.country}';
    } catch (e) {
      locationAddress = 'Error:Location Not Found';
    }
  }
}
