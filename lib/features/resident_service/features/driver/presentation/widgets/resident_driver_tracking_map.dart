import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:wasla/core/utils/assets.dart';
import 'package:wasla/features/resident_service/features/driver/presentation/manager/cubit/resident_driver_cubit.dart';
import 'package:wasla/features/resident_service/features/driver/presentation/widgets/custom_plusing_animation_widget.dart';
import 'package:wasla/features/resident_service/features/home/presentation/manager/cubit/home_resident_cubit.dart';

class ResidentDriverTrackingMap extends StatelessWidget {
  const ResidentDriverTrackingMap({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ResidentDriverCubit>();

    return BlocBuilder<ResidentDriverCubit, ResidentDriverState>(
      buildWhen: (_, current) =>
          current is ResidentDriverChangeDriverLocation ||
          current is ResidentDriverBackToMyLocatonLocation,
      builder: (context, state) {
        return FlutterMap(
          mapController: cubit.mapController,
          options: MapOptions(
            initialCenter: LatLng(cubit.lat, cubit.lng),
            initialZoom: 12,
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
                  point: LatLng(cubit.fromPlace!.lat, cubit.fromPlace!.lng),
                  width: 40,
                  height: 40,
                  child: PulsingAvatar(
                    imageUrl:
                        context.read<HomeResidentCubit>().user?.imageUrl ?? '',
                    withImage: true,
                    size: 40,
                  ),
                ),

                Marker(
                  point: cubit.driverLocation,
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
