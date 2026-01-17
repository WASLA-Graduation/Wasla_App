import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:wasla/core/database/api/api_end_points.dart';
import 'package:wasla/core/database/api/api_interceptors.dart';

class DioFactory {
  static Dio createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiEndPoints.baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        //important for cookies
        extra: {'withCredentials': true},
      ),
    );

    //important for cookies
    final cookieJar = CookieJar();
    //important for cookies
    dio.interceptors.add(CookieManager(cookieJar));

    dio.interceptors.add(ApiInterceptors());

    // dio.interceptors.add(
    //   LogInterceptor(
    //     request: true,
    //     requestHeaders: true,
    //     responseHeader: true,
    //     responseBody: true,
    //   ),
    // );

    return dio;
  }
}
