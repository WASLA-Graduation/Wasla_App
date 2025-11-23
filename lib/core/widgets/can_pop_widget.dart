import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CanPopScreen extends StatelessWidget {
  const CanPopScreen({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) => SystemNavigator.pop(),
      child: child,
    );
  }
}
