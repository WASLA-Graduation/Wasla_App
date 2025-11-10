import 'package:flutter/material.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/widgets/doctor_body.dart';

class DoctorView extends StatelessWidget {
  const DoctorView({super.key});

  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Doctors"), centerTitle: true),
      body: DoctorBody(),
    );
  }
}
