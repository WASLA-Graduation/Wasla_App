import 'package:flutter/material.dart';
import 'package:wasla/features/doctor_service/features/service/presentation/widgets/doctor_service_list.dart';

class ServiceViewBody extends StatelessWidget {
  const ServiceViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Expanded(child: DoctorServiceList())],
        ),
      ),
    );
  }
}
