import 'package:flutter/material.dart';
import 'package:wasla/features/doctor_service/features/home/presentation/widgets/doc_home/doctor_dashboard_body.dart';

class DoctorDashboardView extends StatelessWidget {
  const DoctorDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
        child: DoctorDashboardBody(),
      ),
    );
  }
}
