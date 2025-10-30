import 'package:flutter/material.dart';
import 'package:wasla/core/extensions/config_extension.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/widgets/custom_doctor_image.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/widgets/custom_doctor_info.dart';

class CustomDoctorListItem extends StatelessWidget {
  const CustomDoctorListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: context.isDarkMode ? AppColors.blackTextColor : Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color:context.isDarkMode ? Colors.black12 : Colors.grey.shade300,
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),

      child: Row(
        children: [
          Expanded(flex: 2, child: CustomDoctorImage()),
          Expanded(flex: 3, child: CustomDoctorInfo()),
        ],
      ),
    );
  }
}
