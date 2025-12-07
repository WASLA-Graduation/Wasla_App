import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';

class BookingListHeader extends StatelessWidget {
  const BookingListHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            "bookingList".tr(context),
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
      ],
    );
  }
}
