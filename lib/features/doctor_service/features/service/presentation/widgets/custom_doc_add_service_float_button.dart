import 'package:flutter/material.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/utils/app_colors.dart';

class CustomAddDoctorServiceButton extends StatelessWidget {
  const CustomAddDoctorServiceButton({super.key});
  

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 55,
      height: 55,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
        ),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: () {
          context.pushScreen(AppRoutes.doctorAddServiceScreen);
        },
        icon: Icon(Icons.add, color: AppColors.whiteColor),
      ),
    );
  }
}
