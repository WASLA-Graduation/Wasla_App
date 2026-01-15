import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wasla/core/database/api/api_consumer.dart';
import 'package:wasla/core/database/api/dio_consumer.dart';

final GetIt sl = GetIt.instance;
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void initializeServiceLocator() async {
  //init app services

  sl.registerSingleton<ApiConsumer>(DioConsumer(dio: Dio()));

  //iinit cubits
}
