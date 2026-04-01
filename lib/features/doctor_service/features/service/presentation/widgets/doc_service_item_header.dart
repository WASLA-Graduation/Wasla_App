import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';

class DocServiceItemHeader extends StatelessWidget {
  const DocServiceItemHeader({
    super.key,
    required this.seviceName,
    required this.sevicePrice,
  });
  final String seviceName;
  final double sevicePrice;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            seviceName,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        const SizedBox(width: 20),
        Text(
          "$sevicePrice ${"egb".tr(context)}",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ],
    );
  }
}
