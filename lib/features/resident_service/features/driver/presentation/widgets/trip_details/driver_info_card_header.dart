import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/widgets/custom_circle_network_image.dart';
import 'package:wasla/features/resident_service/features/driver/data/models/resident_trip_model.dart';

class DriverInfoCardHeader extends StatelessWidget {
  const DriverInfoCardHeader({super.key, required this.trip});
  final ResidentTripModel trip;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleNeworkImage(
        imageUrl: trip.driverImage,
        isLoading: false,
      ),

      title: Text(
        trip.driverName,
        style: Theme.of(context).textTheme.labelMedium,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        trip.yearsOfExperience.toString() + 'yearaExperience'.tr(context),
        style: Theme.of(context).textTheme.labelSmall,
      ),

      trailing: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            trip.rating.toString(),
            style: Theme.of(context).textTheme.labelMedium,
          ),
          Text(
            'reviews'.tr(context),
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ],
      ),
    );
  }
}
