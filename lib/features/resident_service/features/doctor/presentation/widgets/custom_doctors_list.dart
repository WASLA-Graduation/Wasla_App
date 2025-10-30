import 'package:flutter/material.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/widgets/custom_doctor_list_item.dart';

class CustomDoctorsList extends StatelessWidget {
  const CustomDoctorsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: 10,
      itemBuilder: (context, index) => CustomDoctorListItem(),
    );
  }
}

