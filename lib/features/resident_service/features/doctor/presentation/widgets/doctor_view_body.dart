import 'package:flutter/material.dart';
import 'package:wasla/core/utils/app_sizes.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/widgets/custom_doctor_speciality_list.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/widgets/doctor_list_widget.dart';

class DoctorViewBody extends StatelessWidget {
  const DoctorViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.marginDefault,
        vertical: AppSizes.paddingSizeEight,
      ),
      child: Column(
        spacing: AppSizes.paddingSizeThelve,
        children: [
          CustomDoctorSpecialityList(),
          Expanded(child: DoctorListWidget()),
        ],
      ),
    );
  }
}
