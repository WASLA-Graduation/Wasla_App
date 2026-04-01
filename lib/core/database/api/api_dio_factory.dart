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
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
        sendTimeout: const Duration(seconds: 60),
        //important for cookies
        extra: {'withCredentials': true},
      ),
    );

    //important for cookies
    final cookieJar = CookieJar();
    //important for cookies
    dio.interceptors.add(CookieManager(cookieJar));

    dio.interceptors.add(ApiInterceptors(dio));
    // dio.interceptors.add(
    //   InterceptorsWrapper(
    //     onRequest: (options, handler) {
    //       print("➡️ Sending request: ${options.uri}");
    //       print("Headers: ${options.headers}");
    //       if (options.data is FormData) {
    //         final formData = options.data as FormData;
    //         print("Fields: ${formData.fields}");
    //         print("Files: ${formData.files.map((f) => f.key).join(', ')}");
    //       }
    //       handler.next(options); // تابع request
    //     },
    //     onResponse: (response, handler) {
    //       print("✅ Response: ${response.statusCode}");
    //       handler.next(response); // تابع response
    //     },
    //     onError: (DioError e, handler) {
    //       print("❌ Error: ${e.message}");
    //       if (e.response != null) {
    //         print("Response data: ${e.response?.data}");
    //       }
    //       handler.next(e); // تابع error
    //     },
    //   ),
    // );

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
