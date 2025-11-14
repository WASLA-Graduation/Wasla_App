import 'package:flutter/material.dart';
import 'package:wasla/core/models/doctor_specializationa_model.dart';
import 'package:wasla/core/utils/app_colors.dart';

class DoctorSpecialityitem extends StatelessWidget {
  final DoctorSpecializationaModel doctorSpecializationaModel;
  final bool isSelected;
  const DoctorSpecialityitem({
    super.key,
    required this.doctorSpecializationaModel,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: ShapeDecoration(
        color: isSelected
            ? AppColors.primaryColor
            : AppColors.gray.withOpacity(0.1),
        shape: StadiumBorder(),
      ),
      child: Center(
        child: Text(
          doctorSpecializationaModel.specialization,
          style: isSelected
              ? Theme.of(
                  context,
                ).textTheme.headlineSmall!.copyWith(color: AppColors.whiteColor)
              : Theme.of(context).textTheme.headlineSmall,
        ),
      ),
    );
  }
}
