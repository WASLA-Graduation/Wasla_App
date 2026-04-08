import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/extensions/config_extension.dart';
import 'package:wasla/core/responsive/size_config.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/app_styles.dart';

class NoInternetWidget extends StatelessWidget {
  final VoidCallback onRetry;
  const NoInternetWidget({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDarkMode;
    final double iconSize = SizeConfig.isTablet ? 120.0 : 80.0;
    final double buttonWidth = SizeConfig.isTablet ? 220.0 : 160.0;
    final double buttonHeight = SizeConfig.isTablet ? 54.0 : 46.0;
    final double spacing = SizeConfig.isTablet ? 24.0 : 16.0;

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.isTablet ? 64.0 : 32.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: iconSize * 1.5,
              height: iconSize * 1.5,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryColor.withOpacity(isDark ? 0.12 : 0.08),
              ),
              child: Icon(
                Icons.wifi_off_rounded,
                size: iconSize,
                color: AppColors.primaryColor,
              ),
            ),
            SizedBox(height: spacing),
            Text(
              'noInternet'.tr(context),
              textAlign: TextAlign.center,
              style: AppStyles.styleBold25(context).copyWith(
                color: isDark ? AppColors.whiteColor : AppColors.blackColor,
              ),
            ),
            SizedBox(height: spacing / 2),
            Text(
              'noInternetMessage'.tr(context),
              textAlign: TextAlign.center,
              style: AppStyles.styleMeduim17(context).copyWith(
                color: isDark
                    ? AppColors.whiteColor.withOpacity(0.6)
                    : AppColors.blackColor.withOpacity(0.5),
                height: 1.5,
              ),
            ),
            SizedBox(height: spacing * 1.5),
            SizedBox(
              width: buttonWidth,
              height: buttonHeight,
              child: ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh_rounded, size: 20),
                label: Text(
                  'retry'.tr(context),
                  style: AppStyles.styleSemiBold16(
                    context,
                  ).copyWith(color: AppColors.whiteColor),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: AppColors.whiteColor,
                  elevation: isDark ? 0 : 2,
                  shadowColor: AppColors.primaryColor.withOpacity(0.4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
