import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wasla/core/connection/network_info.dart';
import 'package:wasla/core/connection/network_info_impl.dart';
import 'package:wasla/core/database/api/api_consumer.dart';
import 'package:wasla/core/database/api/api_dio_factory.dart';
import 'package:wasla/core/database/api/dio_consumer.dart';
import 'package:wasla/features/notifications/service/fcm_notifications.dart';
import 'package:wasla/features/notifications/service/local_notificatons.dart';

final GetIt sl = GetIt.instance;
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<ScaffoldMessengerState> scaffoldMessangerKey =
    GlobalKey<ScaffoldMessengerState>();

void initializeServiceLocator() async {
  final dio = DioFactory.createDio();
  //init app services
  sl.registerSingleton<ApiConsumer>(DioConsumer(dio: dio));
  sl.registerLazySingleton<Connectivity>(() => Connectivity());
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl<Connectivity>()),
  );
  await FcmNotifications.init();
  await LocalNotifications.init();
}
