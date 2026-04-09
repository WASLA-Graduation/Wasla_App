import 'package:url_launcher/url_launcher.dart';

class UrlHelper {

  static Future<void> openWebsite(String url) async {
    final Uri uri = Uri.parse(url,);
    await _launch(uri);
  }

  static Future<void> callPhone(String phoneNumber) async {
    final Uri uri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await _launch(uri);
  }

  static Future<void> openWhatsApp(String phoneNumber) async {
    final Uri uri = Uri.parse("https://wa.me/$phoneNumber");
    await _launch(uri);
  }

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
    await _launch(uri);
  }

  static Future<void> openMapWithCoordinates({
    required double latitude,
    required double longitude,
  }) async {
    final Uri uri = Uri.parse(
      "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude",
    );
    await _launch(uri);
  }

  static Future<void> openMapWithAddress(String address) async {
    final Uri uri = Uri.parse(
      "https://www.google.com/maps/search/?api=1&query=$address",
    );
    await _launch(uri);
  }

  static Future<void> openApp(String url) async {
    final Uri uri = Uri.parse(url);
    await _launch(uri);
  }

  static Future<void> _launch(Uri uri) async {
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $uri');
    }
  }
}