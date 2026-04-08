import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/extensions/config_extension.dart';
import 'package:wasla/core/responsive/size_config.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/app_styles.dart';

class MyErrorWidget extends StatelessWidget {
  final VoidCallback onRetry;
  const MyErrorWidget({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDarkMode;
    final double spacing = SizeConfig.isTablet ? 24.0 : 16.0;
    final double buttonWidth = SizeConfig.isTablet ? 240.0 : 200.0;
    final double buttonHeight = SizeConfig.isTablet ? 54.0 : 48.0;

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.darkbackgroundColor
          : AppColors.lightbackgroundColor,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.isTablet ? 64.0 : 32.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _DoubleGearIcon(isDark: isDark),
              SizedBox(height: spacing * 1.3),
              Text(
                'pageNotFound'.tr(context),
                textAlign: TextAlign.center,
                style: AppStyles.styleBold25(context).copyWith(
                  color: isDark ? AppColors.whiteColor : AppColors.blackColor,
                ),
              ),
              SizedBox(height: spacing / 2),
              Text(
                'technicalProblem'.tr(context),
                textAlign: TextAlign.center,
                style: AppStyles.styleMeduim17(context).copyWith(
                  color: isDark
                      ? AppColors.whiteColor.withOpacity(0.55)
                      : AppColors.blackColor.withOpacity(0.5),
                  height: 1.6,
                ),
              ),
              SizedBox(height: spacing * 1.5),
              SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: ElevatedButton(
                  onPressed: onRetry,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: AppColors.whiteColor,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'retry'.tr(context),
                    style: AppStyles.styleSemiBold16(
                      context,
                    ).copyWith(color: AppColors.whiteColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DoubleGearIcon extends StatelessWidget {
  const _DoubleGearIcon({required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final double bigGear = SizeConfig.isTablet ? 110.0 : 85.0;
    final double smallGear = SizeConfig.isTablet ? 65.0 : 50.0;
    final double containerSize = bigGear + smallGear * 0.6;

    return SizedBox(
      width: containerSize,
      height: containerSize * 0.85,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            child: Icon(
              Icons.settings_rounded,
              size: bigGear,
              color: AppColors.primaryColor,
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Icon(
              Icons.settings_outlined,
              size: smallGear,
              color: isDark
                  ? AppColors.whiteColor.withOpacity(0.9)
                  : AppColors.blackColor.withOpacity(0.2),
            ),
          ),
        ],
      ),
    );
  }
}
