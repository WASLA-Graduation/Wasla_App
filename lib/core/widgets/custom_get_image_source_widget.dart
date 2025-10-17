import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:wasla/core/utils/app_colors.dart';

class GetImageSourceWidget extends StatelessWidget {
  final String image;
  final VoidCallback onPressed;

  const GetImageSourceWidget({
    required this.image,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: const EdgeInsets.all(15),
      elevation: 10,
      shape: CircleBorder(),
      color: AppColors.whiteColor,
      onPressed: onPressed,
      child: Image.asset(image, fit: BoxFit.fill, width: 70, height: 70),
    );
  }
}