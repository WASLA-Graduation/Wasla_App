import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:wasla/core/enums/notifications_routes.dart';

abstract class LocalNotifications {
  static late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  static Future<void> init() async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const InitializationSettings settings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    );

    await flutterLocalNotificationsPlugin.initialize(
      settings: settings,
      // onDidReceiveBackgroundNotificationResponse: handleNotificationWhenOnTap,
      onDidReceiveNotificationResponse: handleNotificationWhenOnTap,
    );
  }

  static Future<void> showNormalNotificaton({
    required RemoteMessage message,
  }) async {
    AndroidNotificationDetails details = AndroidNotificationDetails(
      "id 1",
      "normal notification",
      importance: Importance.max,
      priority: Priority.high,
    );
    flutterLocalNotificationsPlugin.show(
      id: 0,
      title: message.notification?.title,
      body: message.notification?.body,
      payload: jsonEncode({
        "type": message.data['type'],
        "refrenceId": message.data['refrenceId'],
      }),
      notificationDetails: NotificationDetails(android: details),
    );
  }

  static void handleNotificationWhenOnTap(NotificationResponse response) {
    if (response.payload == null) return;

    final data = jsonDecode(response.payload!);
    NotificationRoute route = NotificationRoute.fromInt(
      int.parse(data['type']),
    );


    navigateToRightRoute(
      route: route,
      referenceId: data['refrenceId'],
    );
  }
}
