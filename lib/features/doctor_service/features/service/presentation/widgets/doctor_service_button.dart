import 'package:flutter/material.dart';
import 'package:wasla/core/utils/app_colors.dart';

class DoctorServiceButton extends StatelessWidget {
  const DoctorServiceButton({
    super.key,
    required this.text,
    required this.onTap,
    required this.isDeleteButton,
  });
  final String text;
  final VoidCallback onTap;
  final bool isDeleteButton;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: ShapeDecoration(
          gradient: isDeleteButton
              ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFFFF5F6D), Color(0xFFFFC371)],
                )
              : LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
                ),
          shape: StadiumBorder(),
        ),

        child: Center(
          child: Text(
            text,
            style: Theme.of(
              context,
            ).textTheme.headlineMedium!.copyWith(color: AppColors.whiteColor),
          ),
        ),
      ),
    );
  }
}