import 'package:flutter/material.dart';
import 'package:wasla/core/utils/app_colors.dart';

class UnderLineWidget extends StatelessWidget {
  const UnderLineWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 2,
      decoration: BoxDecoration(
        color: AppColors.grayDark.withOpacity(0.2),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}
