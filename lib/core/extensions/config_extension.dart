import 'package:flutter/material.dart';

extension ConfigExtension on BuildContext {
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
  bool get isArabic => Localizations.localeOf(this).languageCode == 'ar';
  String get locale => Localizations.localeOf(this).languageCode;
}
