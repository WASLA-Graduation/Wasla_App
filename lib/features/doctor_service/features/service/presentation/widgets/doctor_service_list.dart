import 'package:flutter/material.dart';
import 'package:wasla/features/doctor_service/features/service/presentation/widgets/doc_service_item.dart';

class DoctorServiceList extends StatelessWidget {
  const DoctorServiceList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: 4,
      itemBuilder: (context, index) => DocServiceItem(),
    );
  }
}
