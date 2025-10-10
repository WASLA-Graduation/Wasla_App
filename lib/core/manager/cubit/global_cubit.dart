import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/database/cache/shared_preferences_helper.dart';

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
      key: 'themeMode',
      value: themeMode.index,
    );
    emit(GlobalChangeTheme(themeMode: themeMode));
  }

  void getAppTheme() {
    int? themeModeIndex = SharedPreferencesHelper.get(key: 'themeMode') as int?;
    themeMode = ThemeMode.values[themeModeIndex ?? 2];
    emit(GlobalChangeTheme(themeMode: themeMode));
  }

  void changeLanguage({required Locale locale}) async {
    this.locale = locale;
    await SharedPreferencesHelper.set(
      key: 'locale',
      value: locale.languageCode,
    );
    emit(GlobalChangeLanguage(locale: locale));
  }

  void getAppLanguage() {
    String? localeCode = SharedPreferencesHelper.get(key: 'locale') as String?;
    locale = Locale(localeCode ?? 'en');
    emit(GlobalChangeLanguage(locale: locale));
  }
}
