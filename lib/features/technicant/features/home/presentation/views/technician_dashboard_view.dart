import 'package:flutter/material.dart';
import 'package:wasla/features/technicant/features/home/presentation/widgets/technician_dahsboard_body.dart';

class TechnicianDashboardView extends StatefulWidget {
  const TechnicianDashboardView({super.key});

  @override
  State<TechnicianDashboardView> createState() =>
      _TechnicianDashboardViewState();
}

class _TechnicianDashboardViewState extends State<TechnicianDashboardView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: TechincianDashboardBody()));
  }
}
