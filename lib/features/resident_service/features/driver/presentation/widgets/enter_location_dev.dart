import 'package:flutter/material.dart';
import 'package:wasla/features/resident_service/features/driver/presentation/widgets/enter_location_fields.dart';
import 'package:wasla/features/resident_service/features/driver/presentation/widgets/enter_location_icons.dart';

class EnterLocationDev extends StatelessWidget {
  const EnterLocationDev({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(17),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey, width: 0.5),
      ),

      child: Row(
        spacing: 8,
        children: [
          LocatoinFromToIcons(),
          Expanded(child: EnterLocationFields()),
        ],
      ),
    );
  }
}
