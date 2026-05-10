import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/helpers/url_helper.dart';
import 'package:wasla/features/resident_service/features/driver/data/models/resident_trip_model.dart';

class DirverInfoCardFooter extends StatelessWidget {
  const DirverInfoCardFooter({super.key, required this.trip});
  final ResidentTripModel trip;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(Icons.phone, color: Colors.green, size: 28),
      title: InkWell(
        onTap: () {
          UrlHelper.callPhone(trip.driverPhone.toString());
        },
        child: Text(
          trip.driverPhone.toString(),
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ),
      subtitle: Text(
        'phone'.tr(context),
        style: Theme.of(context).textTheme.labelSmall,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Column(
        children: [
          Text(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            '${trip.price.toStringAsFixed(0)} ${"egb".tr(context)}',
            style: Theme.of(context).textTheme.labelMedium,
          ),
          Text(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            'price'.tr(context),
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ],
      ),
    );
  }
}
