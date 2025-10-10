part of 'global_cubit.dart';

sealed class GlobalState {}

final class GlobalInitial extends GlobalState {}

final class GlobalChangeTheme extends GlobalState {
  ThemeMode themeMode;
  GlobalChangeTheme({required this.themeMode});
}

final class GlobalChangeLanguage extends GlobalState {
  Locale locale;
  GlobalChangeLanguage({required this.locale});
}
