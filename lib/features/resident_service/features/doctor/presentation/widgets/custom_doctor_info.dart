import 'package:flutter/material.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/widgets/custom_doctor_info_text.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/widgets/custom_doctor_rating.dart';

class CustomDoctorInfo extends StatelessWidget {
  const CustomDoctorInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 3, child: CustomDoctorInfoText()),
        Expanded(child: CustomDoctorInfoRating()),
      ],
    );
  }
}
