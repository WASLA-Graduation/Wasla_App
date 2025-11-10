import 'package:flutter/material.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/app_styles.dart';
import 'package:wasla/core/responsive/size_config.dart';

ThemeData buildLightTheme(BuildContext context, {required bool isArabic}) {
  return ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.lightbackgroundColor,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.blackColor),
      titleTextStyle: AppStyles.bigDesdcriptionStyle.copyWith(
        fontSize: SizeConfig.textSize * 2.2,
      ),
    ),
    fontFamily: isArabic ? 'Cairo' : 'Roboto',
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.lightbackgroundColor,
    textTheme: TextTheme(
      labelLarge: AppStyles.bigDesdcriptionStyle,
      titleSmall: AppStyles.smallDesdcriptionStyle,
      labelMedium: AppStyles.meduimLableStyle,
      labelSmall: AppStyles.smalTextStyle13Bold,
      bodySmall: AppStyles.smalTextStyle16Bold,
      bodyMedium: AppStyles.meduimTextStyle20Bold,
    ),
  );
}
