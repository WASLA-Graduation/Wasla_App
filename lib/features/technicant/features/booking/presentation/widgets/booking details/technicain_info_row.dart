import 'package:flutter/material.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/app_styles.dart';

class TechnicainInfoRow extends StatelessWidget {
  const TechnicainInfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.isDark,
    this.valueColor,
  });

  final IconData icon;
  final String label;
  final String value;
  final bool isDark;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: isDark
                ? AppColors.primaryColor.withOpacity(0.12)
                : AppColors.primaryColor.withOpacity(0.08),
            borderRadius: BorderRadius.circular(9),
          ),
          child: Icon(icon, size: 15, color: AppColors.primaryColor),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: AppStyles.smallDesdcriptionStyle.copyWith(
              fontSize: 12,
              color: isDark
                  ? AppColors.whiteColor.withOpacity(0.45)
                  : AppColors.gray,
            ),
          ),
        ),
        Text(
          value,
          style: AppStyles.styleSemiBold16(context).copyWith(
            fontSize: 13,
            color: valueColor ??
                (isDark ? AppColors.whiteColor : AppColors.blackColor),
          ),
        ),
      ],
    );
  }
}