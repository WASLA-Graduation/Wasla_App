import 'package:flutter/material.dart';
import 'package:wasla/core/utils/app_colors.dart';

class CustomIdentfierWidget extends StatelessWidget {
  const CustomIdentfierWidget({
    super.key,
    required this.leadingText,
    required this.actionText,
  });
  final String leadingText;
  final String actionText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),

        Row(
          children: [
            Text(leadingText, style: Theme.of(context).textTheme.labelMedium),
            Spacer(),
            Text(
              actionText,
              style: Theme.of(
                context,
              ).textTheme.titleSmall!.copyWith(color: AppColors.primaryColor),
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
