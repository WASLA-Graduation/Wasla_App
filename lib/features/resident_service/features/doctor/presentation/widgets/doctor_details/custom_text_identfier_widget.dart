import 'package:flutter/material.dart';
import 'package:wasla/core/utils/app_colors.dart';

class TextDetailsIdentfierWidget extends StatelessWidget {
  final String leading;
  final String trailing;
  final VoidCallback? onTap;
  final bool? bigFont;
  const TextDetailsIdentfierWidget({
    super.key,
    required this.leading,
    required this.trailing,
    this.onTap,
    this.bigFont,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(leading, style: Theme.of(context).textTheme.headlineMedium),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: InkWell(
            onTap: onTap,

            child: Text(
              trailing,
              style: bigFont == true
                  ? Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                    )
                  : Theme.of(context).textTheme.displaySmall!.copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
