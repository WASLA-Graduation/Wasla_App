import 'package:flutter/material.dart';
import 'package:wasla/core/utils/app_colors.dart';

class CustomDividerText extends StatelessWidget {
  const CustomDividerText({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(color: AppColors.gray, height: 1)),
        Text(text, style: Theme.of(context).textTheme.titleSmall),
        Expanded(child: Divider(color: AppColors.gray, height: 1)),
      ],
    );
  }
}