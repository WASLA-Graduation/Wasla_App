import 'package:flutter/foundation.dart';

class LoggerHelper {
  static void info(String message) {
    if (kDebugMode) {
      print("ℹ️ $message");
    }
  }

  static void warning(String message) {
    if (kDebugMode) {
      print("⚠️ $message");
    }
  }

  static void error(String message, {Object? error}) {
    if (kDebugMode) {
      print("❌ $message ${error != null ? "| $error" : ""}");
    }
  }

  static void success(String message) {
    if (kDebugMode) {
      print("✅ $message");
    }
  }
}
