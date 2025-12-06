import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/database/cache/shared_preferences_helper.dart';
import 'package:wasla/core/utils/app_strings.dart';

part 'global_state.dart';

class GlobalCubit extends Cubit<GlobalState> {
  ThemeMode themeMode = ThemeMode.system;
  Locale locale = const Locale('en');

  GlobalCubit() : super(GlobalInitial()) {
    getAppTheme();
    getAppLanguage();
  }

  void changeTheme({required ThemeMode themeMode}) async {
    this.themeMode = themeMode;
    await SharedPreferencesHelper.set(
      key: AppStrings.themMode,
      value: themeMode.index,
    );
    emit(GlobalChangeTheme(themeMode: themeMode));
  }

  void getAppTheme() {
    int? themeModeIndex =
        SharedPreferencesHelper.get(key: AppStrings.themMode) as int?;
    themeMode = ThemeMode.values[themeModeIndex ?? 2];
    emit(GlobalChangeTheme(themeMode: themeMode));
  }

  void changeLanguage({required Locale locale}) async {
    this.locale = locale;
    await SharedPreferencesHelper.set(
      key: AppStrings.locle,
      value: locale.languageCode,
    );
    emit(GlobalChangeLanguage(locale: locale));
  }

  void getAppLanguage() {
    String? localeCode =
        SharedPreferencesHelper.get(key: AppStrings.locle) as String?;
    locale = Locale(localeCode ?? 'en');
    emit(GlobalChangeLanguage(locale: locale));
  }

  
}
