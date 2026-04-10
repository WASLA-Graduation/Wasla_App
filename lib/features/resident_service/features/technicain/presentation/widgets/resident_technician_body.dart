import 'package:flutter/material.dart';
import 'package:wasla/core/responsive/size_config.dart';
import 'package:wasla/features/resident_service/features/technicain/presentation/widgets/resident_all_technicals_list.dart';
import 'package:wasla/features/resident_service/features/technicain/presentation/widgets/resident_tech_specialization_list.dart';

class ResidentTechnicianBody extends StatelessWidget {
  const ResidentTechnicianBody({super.key});

  @override
  Widget build(BuildContext context) {
    final double hSpace = SizeConfig.isTablet ? 24 : 18;
    final double vSpace = SizeConfig.isTablet ? 25 : 15;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: hSpace),
      child: Column(
        children: [
          SizedBox(height: vSpace),
          ResidentTechSpacializationList(),
          SizedBox(height: vSpace),
          Expanded(child: ResidentAllTechinicalsList()),
          SizedBox(height: vSpace),
        ],
      ),
    );
  }
}
