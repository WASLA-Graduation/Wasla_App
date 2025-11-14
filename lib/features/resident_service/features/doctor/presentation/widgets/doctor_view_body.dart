import 'package:flutter/material.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/widgets/custom_doctor_speciality_list.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/widgets/doctor_list_widget.dart';

class DoctorViewBody extends StatelessWidget {
  const DoctorViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20,right: 20,left: 20),
      child: Column(
        children: [
          CustomDoctorSpecialityList(),
          const SizedBox(height: 10),
          Expanded(child: DoctorListWidget()),
        ],
      ),
    );
  }
}
