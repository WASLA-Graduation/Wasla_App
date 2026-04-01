import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/features/resident_service/features/driver/presentation/manager/cubit/resident_driver_cubit.dart';
import 'package:wasla/features/resident_service/features/driver/presentation/widgets/custom_plusing_animation_widget.dart';
import 'package:wasla/features/resident_service/features/home/presentation/manager/cubit/home_resident_cubit.dart';

class ResidentCurrentLocationMap extends StatelessWidget {
  const ResidentCurrentLocationMap({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ResidentDriverCubit>();
    return BlocBuilder<ResidentDriverCubit, ResidentDriverState>(
      buildWhen: (previous, current) =>
          current is ResidentDriverGetMyLocationSuccessState,
      builder: (context, state) {
        return FlutterMap(
          options: MapOptions(
            initialCenter: LatLng(cubit.lat, cubit.lng),
            initialZoom: 10.0,
          ),
          children: [
            TileLayer(
              urlTemplate:
                  'https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}{r}.png',
              subdomains: ['a', 'b', 'c'],
              userAgentPackageName: 'com.wasla.app',
            ),
            MarkerLayer(
              markers: [
                Marker(
                  child: PulsingAvatar(
                    withImage: true,
                    imageUrl:
                        context.read<HomeResidentCubit>().user?.imageUrl ?? '',
                    size: 30,
                    glowColor: AppColors.primaryColor,
                  ),
                  width: 100.0,
                  height: 100.0,
                  point: LatLng(cubit.lat, cubit.lng),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
