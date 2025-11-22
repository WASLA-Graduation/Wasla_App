import 'package:flutter/material.dart';

extension CustomNavigatorExtension on BuildContext {
  void pushReplacementScreen(String routeName, {Object? arguments}) {
    Navigator.of(this).pushReplacementNamed(routeName, arguments: arguments);
  }

  void pushScreen(String routeName, {Object? arguments}) {
    Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }

  void popScreen([Object? result]) {
    Navigator.of(this).pop(result);
  }

  void pushAndRemoveAllScreens(String routeName, {Object? arguments}) {
    Navigator.of(
      this,
    ).pushNamedAndRemoveUntil(routeName, (_) => false, arguments: arguments);
  }
}
