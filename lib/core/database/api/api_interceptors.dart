import 'package:dio/dio.dart';
import 'package:wasla/core/database/cache/shared_preferences_helper.dart';

class ApiInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final String lang = SharedPreferencesHelper.get(key: 'locale') ?? 'en';
    options.queryParameters.addAll({"lan": lang});
    super.onRequest(options, handler);
  }
}
