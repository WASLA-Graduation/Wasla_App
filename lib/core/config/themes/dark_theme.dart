import 'package:flutter/material.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/app_styles.dart';
import 'package:wasla/core/responsive/size_config.dart';

ThemeData buildDarkTheme(BuildContext context, {required bool isArabic}) {
  return ThemeData(
    appBarTheme: AppBarTheme(
      titleTextStyle: AppStyles.bigDesdcriptionStyle.copyWith(
        fontSize: SizeConfig.textSize * 2.2,
        color: AppColors.whiteColor,
      ),
      iconTheme: IconThemeData(color: AppColors.whiteColor),
      backgroundColor: AppColors.darkbackgroundColor,
      elevation: 0,
    ),
    fontFamily: isArabic ? 'Cairo' : 'Roboto',
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkbackgroundColor,
    textTheme: TextTheme(
      labelLarge: AppStyles.bigDesdcriptionStyle.copyWith(
        color: AppColors.whiteColor,
      ),
      titleSmall: AppStyles.smallDesdcriptionStyle,
      labelMedium: AppStyles.meduimLableStyle.copyWith(
        color: AppColors.whiteColor,
      ),
      labelSmall: AppStyles.smalTextStyle13Bold,
      bodySmall: AppStyles.smalTextStyle16Bold.copyWith(
        color: AppColors.whiteColor,
      ),
      bodyMedium: AppStyles.meduimTextStyle20Bold.copyWith(
        color: AppColors.whiteColor,
      ),
      headlineSmall: AppStyles.styleSemiBold16(
        context,
      ).copyWith(color: AppColors.whiteColor),

      headlineMedium: AppStyles.styleSemiBold20(context),
      displaySmall: AppStyles.styleMeduim17(context)
    ),
  );
}
