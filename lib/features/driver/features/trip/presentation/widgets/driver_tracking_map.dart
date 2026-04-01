import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:wasla/core/utils/assets.dart';
import 'package:wasla/features/driver/features/trip/presentation/manager/cubit/driver_trip_cubit.dart';

class DriverTrackingMap extends StatelessWidget {
  const DriverTrackingMap({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DriverTripCubit>();
    return BlocBuilder<DriverTripCubit, DriverTripState>(
      buildWhen: (_, current) =>
          current is DriverChangeMyLocation ||
          current is DriverBackToMyLocation,
    
      builder: (context, state) {
        return FlutterMap(
          mapController: cubit.mapController,
          options: MapOptions(
            initialCenter: cubit.driverLocation!,
            initialZoom: 15,
          ),
          children: [
            TileLayer(
              urlTemplate:
                  'https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}{r}.png',
              subdomains: const ['a', 'b', 'c'],
              userAgentPackageName: 'com.wasla.app',
            ),

            if (cubit.routePoints.isNotEmpty)
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: cubit.routePoints,
                    strokeWidth: 5,
                    color: Colors.blue,
                  ),
                ],
              ),

            MarkerLayer(
              markers: [
                Marker(
                  point: cubit.passengerLocation,
                  width: 40,
                  height: 40,
                  child: const Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 25,
                  ),
                ),
                Marker(
                  point: cubit.driverLocation!,
                  width: 50,
                  height: 50,
                  child: Transform.rotate(
                    angle: cubit.driverRotation * (3.14159265359 / 180),
                    child: Image.asset(
                      Assets.assetsImagesTopCar,
                      width: 30,
                      height: 30,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
