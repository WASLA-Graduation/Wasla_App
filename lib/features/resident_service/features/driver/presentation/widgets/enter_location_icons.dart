import 'package:flutter/material.dart';
import 'package:wasla/features/resident_service/features/driver/presentation/widgets/vertical_dashed_divider.dart';

class LocatoinFromToIcons extends StatelessWidget {
  const LocatoinFromToIcons({super.key, this.height = 40});

  final double height;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(Icons.location_on, color: Colors.green, size: 28),
        DashedDivider(height: height),
        Icon(Icons.location_on, color: Colors.red, size: 28),
      ],
    );
  }
}
