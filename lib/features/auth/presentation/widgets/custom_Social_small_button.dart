import 'package:flutter/material.dart';
import 'package:wasla/core/utils/app_colors.dart';

class CustomSocialSmallButton extends StatelessWidget {
  const CustomSocialSmallButton({
    super.key,
    required this.onPressed,
    required this.image,
  });
  final VoidCallback onPressed;
  final String image;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 60,
        height: 45,
        padding: EdgeInsets.all(7),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.gray, width: 0.5),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Image.asset(image),
      ),
    );
  }
}
