import 'package:flutter/material.dart';
import 'package:wasla/core/helpers/url_helper.dart';
import 'package:wasla/core/utils/app_colors.dart';

class TechnicianPhoneButton extends StatelessWidget {
  const TechnicianPhoneButton({
    super.key,
    required this.phone,
    required this.isDark,
  });

  final String phone;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        UrlHelper.callPhone(phone);
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: isDark
              ? AppColors.primaryColor.withOpacity(0.15)
              : AppColors.primaryColor.withOpacity(0.08),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          Icons.phone_rounded,
          size: 18,
          color: AppColors.primaryColor,
        ),
      ),
    );
  }
}
