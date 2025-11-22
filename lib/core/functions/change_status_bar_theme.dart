import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wasla/core/utils/app_colors.dart';

void changeThemeStatusBar(ThemeMode themeMode) {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: themeMode == ThemeMode.dark
          ? AppColors.darkbackgroundColor
          : AppColors.lightbackgroundColor,
      statusBarIconBrightness: themeMode == ThemeMode.dark
          ? Brightness.light
          : Brightness.dark,
    ),
  );
}
