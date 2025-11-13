import 'package:flutter/material.dart';
import 'package:wasla/core/models/doctor_specializationa_model.dart';
import 'package:wasla/core/utils/app_colors.dart';

class DoctorSpecialityitem extends StatelessWidget {
  final DoctorSpecializationaModel doctorSpecializationaModel;
  const DoctorSpecialityitem({
    super.key,
    required this.doctorSpecializationaModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 3),
      decoration: ShapeDecoration(
        color: AppColors.gray.withOpacity(0.1),
        shape: StadiumBorder(),
      ),
      child: Center(
        child: Text(
          doctorSpecializationaModel.specialization,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
    );
  }
}
