import 'package:flutter/material.dart';
import 'package:wasla/core/utils/app_colors.dart';

class CustomDocDashboardCard extends StatelessWidget {
  const CustomDocDashboardCard({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: AppColors.primaryColor, width: 0.5),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        spacing: 17,
        children: [
          Text(
            overflow: TextOverflow.ellipsis,
            maxLines: 1,

            title,
            style: Theme.of(
              context,
            ).textTheme.displaySmall!.copyWith(color: AppColors.gray),
          ),

          Text(
            value,
            style: Theme.of(
              context,
            ).textTheme.displayMedium!.copyWith(color: AppColors.primaryColor),
          ),
        ],
      ),
    );
  }
}
