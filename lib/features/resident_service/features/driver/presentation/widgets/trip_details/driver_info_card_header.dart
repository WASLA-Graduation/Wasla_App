import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/service/signalR/chat_hub.dart';
import 'package:wasla/core/utils/app_strings.dart';
import 'package:wasla/core/utils/assets.dart';
import 'package:wasla/core/widgets/custom_circle_network_image.dart';
import 'package:wasla/features/resident_service/features/driver/data/models/resident_trip_model.dart';

class DriverInfoCardHeader extends StatelessWidget {
  const DriverInfoCardHeader({super.key, required this.trip});
  final ResidentTripModel trip;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minTileHeight: 80,
      contentPadding: EdgeInsets.zero,
      leading: CircleNeworkImage(imageUrl: trip.driverImage, isLoading: false),

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

      trailing: IconButton(
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
        onPressed: () async {
          final chatHub = ChatHub();
          chatHub.init();
          await context.push(
            AppRoutes.chatScreen,
            extra: {
              AppStrings.id: trip.driverId,
              AppStrings.name: trip.driverName,
              AppStrings.photo: trip.driverImage,
            },
          );
          chatHub.disconnect();
        },
        icon: Image.asset(Assets.assetsImagesChatFilled, height: 22, width: 22),
      ),
    );
  }
}
