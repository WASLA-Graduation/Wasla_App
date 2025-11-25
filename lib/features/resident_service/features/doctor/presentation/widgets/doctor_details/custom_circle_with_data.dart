import 'package:flutter/material.dart';
import 'package:wasla/core/utils/app_colors.dart';

class CircleAvatarWithDetailsWidget extends StatelessWidget {
  const CircleAvatarWithDetailsWidget({
    super.key,
    required this.title,
    required this.num,
    required this.icon,
  });

  final String title;
  final String num;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 6,
      children: [
        CircleAvatar(
          radius: 27,
          backgroundColor: AppColors.primaryColor.withOpacity(0.1),
          child: Image.asset(icon, color: AppColors.primaryColor, height: 20),
        ),
        Text(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          num,
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          title,
          style: Theme.of(context).textTheme.labelSmall!.copyWith(
            color: AppColors.gray,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
