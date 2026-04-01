import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';

class ShowDriverTrackTile extends StatelessWidget {
  const ShowDriverTrackTile({
    super.key,
    required this.title,
    required this.route,
    required this.showMap,
  });
  final String title;
  final String route;
  final bool showMap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        if (showMap) {
          context.pushScreen(route);
        }
      },
      contentPadding: EdgeInsets.zero,
      leading: Icon(Icons.location_on, color: Colors.red, size: 28),
      title: Text(
        title.tr(context),
        style: Theme.of(context).textTheme.labelMedium,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Icon(Icons.arrow_forward_ios, color: Colors.black, size: 20),
    );
  }
}
