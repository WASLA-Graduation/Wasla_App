import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:wasla/core/service/maps/cubit/maps_helper_cubit.dart';
import 'package:wasla/features/auth/presentation/widgets/custom_control_map_zoom_widget.dart';
import 'package:wasla/features/auth/presentation/widgets/custom_current_location_widget.dart';
import 'package:wasla/features/auth/presentation/widgets/custom_save_current_location.dart';

class CustomAuthMapWidget extends StatelessWidget {
  const CustomAuthMapWidget({
    super.key,
    required this.cubit,
  });

  final MapsHelperCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          FlutterMap(
            mapController: cubit.mapController,
            options: MapOptions(
              onTap: (_, latlng) => cubit.updateMapLocation(
                lat: latlng.latitude,
                long: latlng.longitude,
              ),
              initialCenter: LatLng(
                cubit.lat,
                cubit.long,
              ), // Center the map over London
              initialZoom: cubit.mapZoom,
            ),
            children: [
              TileLayer(
                // Bring your own tiles
                urlTemplate:
                    'https://tile.openstreetmap.org/{z}/{x}/{y}.png', // For demonstration only
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    child: const Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 35,
                    ),
                    width: 100.0,
                    height: 100.0,
                    point: LatLng(cubit.lat, cubit.long),
                  ),
                ],
              ),
            ],
          ),
          CurrentLocationWidget(),
          ControlMapZoomWidget(),
          SaveCurrentLocationWidget(),
        ],
      );
  }
}