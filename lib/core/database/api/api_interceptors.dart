import 'package:dio/dio.dart';
import 'package:wasla/core/database/api/api_end_points.dart';
import 'package:wasla/core/database/api/api_keys.dart';
import 'package:wasla/core/database/cache/secure_storage_helper.dart';
import 'package:wasla/core/database/cache/shared_preferences_helper.dart';
import 'package:wasla/core/utils/app_strings.dart';

class ApiInterceptors extends Interceptor {
  final Dio dio;

  ApiInterceptors(this.dio);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final String lang =
        SharedPreferencesHelper.get(key: AppStrings.locle) ?? 'en';
    options.queryParameters.addAll({"lan": lang});

    final String? accessToken = await SecureStorageHelper.get(
      key: ApiKeys.token,
    );

    options.extra['withCredentials'] = true;

    if (accessToken != null && accessToken.isNotEmpty) {
      options.headers.addAll({
        "Authorization": "Bearer $accessToken",
        "Content-Type": "application/json",
      });
    } else {
      options.headers.addAll({"Content-Type": "application/json"});
    }

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final requestOptions = err.requestOptions;
      try {
        final refreshResponse = await dio.post(
          ApiEndPoints.refreshToken,
          options: Options(headers: {"Content-Type": "application/json"}),
        );

        final newAccessToken = refreshResponse.data['data']['token'];
        if (newAccessToken != null) {
          await SecureStorageHelper.set(
            key: ApiKeys.token,
            value: newAccessToken,
          );
          requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';
          final response = await dio.fetch(requestOptions);
          return handler.resolve(response);
        }
      } catch (e) {
        return handler.reject(err);
      }
    }

    super.onError(err, handler);
  }
}
