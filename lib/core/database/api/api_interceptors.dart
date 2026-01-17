import 'package:dio/dio.dart';
import 'package:wasla/core/database/cache/shared_preferences_helper.dart';
import 'package:wasla/core/utils/app_strings.dart';

class ApiInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final String lang =
        SharedPreferencesHelper.get(key: AppStrings.locle) ?? 'en';
    options.queryParameters.addAll({"lan": lang});
    options.extra['withCredentials'] = true;
    super.onRequest(options, handler);
  }
}
