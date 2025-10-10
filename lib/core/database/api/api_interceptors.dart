import 'package:dio/dio.dart';

class ApiInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    //send in query parameters or in headers the language code

    // options.queryParameters.addAll({'lang': 'en'});
    super.onRequest(options, handler);
  }
}