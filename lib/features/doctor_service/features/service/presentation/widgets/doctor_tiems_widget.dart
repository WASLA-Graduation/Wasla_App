import 'package:flutter/material.dart';
import 'package:wasla/core/utils/app_colors.dart';

class DoctorTimesWidget extends StatelessWidget {
  const DoctorTimesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Text(
        "24 Nov | 26 Nov | 08:00 to 16:00",
        style: Theme.of(
          context,
        ).textTheme.displaySmall!.copyWith(color: AppColors.primaryColor),
      ),
    );
  }
}