import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/widgets/custom_circle_network_image.dart';
import 'package:wasla/features/resident_service/features/driver/data/models/resident_trip_model.dart';

class DriverInfoCarDetails extends StatelessWidget {
  const DriverInfoCarDetails({super.key, required this.trip});
  final ResidentTripModel trip;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleNeworkImage(imageUrl: trip.vehicleImage, isLoading: false),

      title: Text(
        'Chavrolet Camaro',
        style: Theme.of(context).textTheme.labelMedium,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        // 'CCG-370 Red'
        '${trip.vehicleNumber}  ${trip.vehicleColor}',
        style: Theme.of(context).textTheme.labelSmall,
      ),

      trailing: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            trip.vehicleModel,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          Text(
            'model'.tr(context),
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ],
      ),
    );
  }
}
