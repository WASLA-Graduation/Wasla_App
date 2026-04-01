import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wasla/core/service/service_locator.dart';

void toastAlert({required String msg, required Color color}) {
  final overlayState = Overlay.of(
    navigatorKey.currentContext!,
  ); // Global navigatorKey
  final overlayEntry = OverlayEntry(
    builder: (_) => Positioned(
      bottom: 50,
      left: 20,
      right: 20,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(msg, style: const TextStyle(color: Colors.white)),
          ),
        ),
      ),
    ),
  );

  overlayState.insert(overlayEntry);
  Future.delayed(const Duration(seconds: 2), () => overlayEntry.remove());
}

void showToast(String msg, {Color color = Colors.black}) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.SNACKBAR,
    backgroundColor: color,
    textColor: Colors.white,
    fontSize: 16,
  );
}
