import 'package:flutter/material.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/app_styles.dart';

class StatCard extends StatelessWidget {
  const StatCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.subValue,
    required this.isDark,
    this.valueColor,
  });

  final IconData icon;
  final String label;
  final String value;
  final String subValue;
  final bool isDark;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.whiteColor.withOpacity(0.05)
            : const Color(0xFFF7FAFF),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark
              ? AppColors.whiteColor.withOpacity(0.08)
              : AppColors.primaryColor.withOpacity(0.10),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.primaryColor.withOpacity(0.15)
                  : AppColors.primaryColor.withOpacity(0.08),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 16, color: AppColors.primaryColor),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: AppStyles.smalTextStyle13Bold.copyWith(
              fontSize: 11,
              color: isDark
                  ? AppColors.whiteColor.withOpacity(0.4)
                  : AppColors.gray,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            value,
            style: AppStyles.styleSemiBold16(context).copyWith(
              fontSize: 13,
              color: valueColor ??
                  (isDark ? AppColors.whiteColor : AppColors.blackColor),
            ),
          ),
          Text(
            subValue,
            style: AppStyles.smalTextStyle13Bold.copyWith(
              fontSize: 11,
              color: isDark
                  ? AppColors.whiteColor.withOpacity(0.4)
                  : AppColors.gray,
            ),
          ),
        ],
      ),
    );
  }
}