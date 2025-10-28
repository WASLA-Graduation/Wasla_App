import 'package:flutter/material.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/app_styles.dart';
import 'package:wasla/core/utils/size_config.dart';

abstract class AppThemes {
  static ThemeData lightTheme({required String fontFamily}) {
    return ThemeData(
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.lightbackgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.blackColor),
        titleTextStyle: AppStyles.bigDesdcriptionStyle.copyWith(
          fontSize: SizeConfig.textSize * 2.2,
        ),
      ),
      fontFamily: fontFamily,
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

  static ThemeData darkTheme({required String fontFamily}) {
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
      fontFamily: fontFamily,
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
        bodyMedium: AppStyles.meduimTextStyle20Bold,
      ),
    );
  }
}
