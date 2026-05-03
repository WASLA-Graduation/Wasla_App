import 'package:url_launcher/url_launcher.dart';

class UrlHelper {
  /// ================================
  /// Core Launcher
  /// ================================
  static Future<void> _launch(Uri uri, {bool inApp = false}) async {
    final mode = inApp
        ? LaunchMode.inAppBrowserView
        : LaunchMode.externalApplication;

    if (!await launchUrl(uri, mode: mode)) {
      throw Exception('Could not launch $uri');
    }
  }

  /// ================================
  /// Website
  /// ================================
  static Future<void> openWebsite(String url, {bool inApp = true}) async {
    final Uri uri = Uri.parse(url);
    await _launch(uri, inApp: inApp);
  }

  /// ================================
  /// Phone Call
  /// ================================
  static Future<void> callPhone(String phoneNumber) async {
    final Uri uri = Uri(scheme: 'tel', path: phoneNumber);
    await _launch(uri);
  }

  /// ================================
  /// WhatsApp
  /// ================================
  static Future<void> openWhatsApp(
    String phoneNumber, {
    bool inApp = false,
  }) async {
    final Uri uri = Uri.parse("https://wa.me/$phoneNumber");
    await _launch(uri, inApp: inApp);
  }

  /// ================================
  /// Email
  /// ================================
  static Future<void> sendEmail({
    required String email,
    String? subject,
    String? body,
  }) async {
    final Uri uri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        if (subject != null) 'subject': subject,
        if (body != null) 'body': body,
      },
    );

    await _launch(uri); // برا الأب
  }

  /// ================================
  /// Maps (Coordinates)
  /// ================================
  static Future<void> openMapWithCoordinates({
    required double latitude,
    required double longitude,
    bool inApp = false,
  }) async {
    final Uri uri = Uri.parse(
      "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude",
    );

    await _launch(uri, inApp: inApp);
  }

  /// ================================
  /// Maps (Address)
  /// ================================
  static Future<void> openMapWithAddress(
    String address, {
    bool inApp = false,
  }) async {
    final Uri uri = Uri.parse(
      "https://www.google.com/maps/search/?api=1&query=$address",
    );

    await _launch(uri, inApp: inApp);
  }

  /// ================================
  /// Any App / Link
  /// ================================
  static Future<void> openApp(String url, {bool inApp = false}) async {
    final Uri uri = Uri.parse(url);
    await _launch(uri, inApp: inApp);
  }
}
