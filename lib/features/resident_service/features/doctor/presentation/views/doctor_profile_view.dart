import 'package:flutter/material.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/widgets/doctor_profile_body.dart';

class DoctorProfileView extends StatelessWidget {
  const DoctorProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Doctor Profile"),
        centerTitle: true,
        forceMaterialTransparency: true,
      ),
      body: DoctorProfileBody(),
    );
  }
}
