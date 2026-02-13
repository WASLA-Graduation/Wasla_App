import 'package:flutter/material.dart';
import 'package:wasla/core/utils/app_colors.dart';

class CustomFloatingAddButton extends StatelessWidget {
  const CustomFloatingAddButton({super.key, required this.onPressed});
  final VoidCallback? onPressed;

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
        onPressed: onPressed,
        icon: Icon(Icons.add, color: AppColors.whiteColor),
      ),
    );
  }
}
