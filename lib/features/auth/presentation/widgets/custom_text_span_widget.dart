import 'package:flutter/material.dart';
import 'package:wasla/core/utils/app_colors.dart';

class CustomTextSpanWidget extends StatelessWidget {
  final String leadingText;
  final String suffixText;
  final VoidCallback? onTap;

  const CustomTextSpanWidget({
    super.key,
    required this.leadingText,
    required this.suffixText, this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(leadingText, style: Theme.of(context).textTheme.titleSmall),
        SizedBox(width: 4),
        GestureDetector(
          onTap: onTap,
          child: Text(
            suffixText,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: AppColors.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
