import 'package:flutter/material.dart';
import 'package:wasla/core/functions/format_time_with_intl.dart';
import 'package:wasla/features/resident_service/features/driver/presentation/widgets/enter_location_icons.dart';

class DriverCardInfoSourceDest extends StatelessWidget {
  const DriverCardInfoSourceDest({
    super.key,
    required this.source,
    required this.destination,
    required this.sourceDate,
    required this.destinationDate,
  });
  final String source;
  final String destination;
  final DateTime sourceDate;
  final DateTime destinationDate;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          LocatoinFromToIcons(height: 25),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              children: [
                Row(
                  spacing: 10,
                  children: [
                    Expanded(
                      child: Text(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        source,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),
                    Text(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      formatDateTimeWithIntl(sourceDate),
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
                const Spacer(),
                Divider(
                  height: 20,
                  thickness: 0.3,
                  color: Colors.grey.shade300,
                ),
                const Spacer(),

                Row(
                  spacing: 10,
                  children: [
                    Expanded(
                      child: Text(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        destination,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),
                    Text(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      formatDateTimeWithIntl(destinationDate),
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
