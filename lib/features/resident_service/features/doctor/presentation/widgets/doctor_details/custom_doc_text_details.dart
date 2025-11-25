import 'package:flutter/material.dart';
import 'package:wasla/core/utils/app_colors.dart';

class CustomDoctorDetailsText extends StatelessWidget {
  const CustomDoctorDetailsText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDoctorName(context),
        Divider(height: 24, color: AppColors.primaryColor, thickness: .1),
        _buildDoctorHostpital(context),
        const SizedBox(height: 10),
        _buildDoctorSpaciality(context),
      ],
    );
  }

  Text _buildDoctorSpaciality(BuildContext context) {
    return Text(
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        "Dematology",
        style: Theme.of(
          context,
        ).textTheme.labelSmall!.copyWith(color: AppColors.gray),
      );
  }

  Text _buildDoctorHostpital(BuildContext context) {
    return Text(
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        "Christ Hospital",
        style: Theme.of(
          context,
        ).textTheme.labelSmall!.copyWith(color: AppColors.gray),
      );
  }

  Text _buildDoctorName(BuildContext context) {
    return Text(
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        "Dr.Randy Wigham",
        style: Theme.of(context).textTheme.headlineMedium,
      );
  }
}
