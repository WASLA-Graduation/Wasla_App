import 'package:flutter/material.dart';
import 'package:wasla/core/widgets/custom_more_app_bar_widget.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/widgets/doctor_details/doctor_details_body.dart';

class DoctorDetailsView extends StatelessWidget {
  const DoctorDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dr.Randy Wigham"),
        forceMaterialTransparency: true,
        actions: [CustomMoreAppBarWidget()],
      ),
      body: DoctorDetailsBody(),
    );
  }
}
