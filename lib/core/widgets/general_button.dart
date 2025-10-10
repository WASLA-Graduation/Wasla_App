import 'package:flutter/material.dart';
import 'package:wasla/core/utils/app_colors.dart';

class GeneralButton extends StatelessWidget {
  const GeneralButton({
    super.key,
    required this.onPressed,
    this.color,
    this.height,
    required this.text,
  });
  final VoidCallback onPressed;
  final Color? color;
  final double? height;
  final String text;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: color ?? AppColors.primaryColor,
      minWidth: double.infinity,
      height: height ?? 60,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 18, color: AppColors.whiteColor),
      ),
    );
  }
}
