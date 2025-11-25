import 'package:flutter/material.dart';
import 'package:wasla/core/utils/app_colors.dart';

class TextDetailsIdentfierWidget extends StatelessWidget {
  final String leading;
  final String trailing;
  const TextDetailsIdentfierWidget({
    super.key,
    required this.leading,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(leading, style: Theme.of(context).textTheme.headlineMedium),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            trailing,
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
