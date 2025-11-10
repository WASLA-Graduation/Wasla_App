import 'package:flutter/material.dart';
import 'package:wasla/core/config/themes/dark_theme.dart';
import 'package:wasla/core/config/themes/light_theme.dart';
import 'package:wasla/core/database/cache/shared_preferences_helper.dart';
import 'package:wasla/core/utils/app_strings.dart';

abstract class AppThemes {
  static lightTheme(BuildContext context) {
    return buildLightTheme(context, isArabic: isArabic());
  }

  static darkTheme(BuildContext context) {
    return buildDarkTheme(context, isArabic: isArabic());
  }

  static bool isArabic() {
    final String lang =
        SharedPreferencesHelper.get(key: AppStrings.locle) ?? 'en';

    if (lang == 'ar') {
      return true;
    } else {
      return false;
    }
  }
}
