import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:wasla/app/wasla_app.dart';
import 'package:wasla/core/database/cache/shared_preferences_helper.dart';
import 'package:wasla/core/service/service_locator.dart';
import 'package:wasla/features/notifications/service/fcm_notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesHelper.init();
  await Firebase.initializeApp();
  initializeServiceLocator();

  FcmNotifications.whenTappedOnBackgroundNotificaton();

  FcmNotifications.whenTappedOnTerminatedNotificaton();

  FirebaseMessaging.onBackgroundMessage(
    handleBackgroundAndTerminatedNotifications,
  );

  runApp(
    // DevicePreview(
    //   enabled: !kReleaseMode,
    //   builder: (context) {
    //     return WaslaApp();
    //   },
    // ),
    WaslaApp(),
  );
}
