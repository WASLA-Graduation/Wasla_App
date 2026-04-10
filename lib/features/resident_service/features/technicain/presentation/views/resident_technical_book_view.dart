import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/features/resident_service/features/technicain/presentation/widgets/resident_tech_book_body.dart';

class ResidentTechnicalBookView extends StatelessWidget {
  const ResidentTechnicalBookView({super.key, required this.technicianId});

  final String technicianId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('booking'.tr(context)),
        scrolledUnderElevation: 0,
      ),

      body: SafeArea(
        child: ResidentTechnicalBookViewBody(technicianId: technicianId),
      ),
    );
  }
}
