import 'package:flutter/material.dart';

extension CustomNavigatorExtension on BuildContext {
  void pushReplacementScreen(String routeName) {
    Navigator.of(this).pushReplacementNamed(routeName);
  }

  void pushScreen(String routeName) {
    Navigator.of(this).pushNamed(routeName);
  }

  void popScreen() {
    Navigator.of(this).pop();
  }
}
