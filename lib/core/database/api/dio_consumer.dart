import 'package:dio/dio.dart';
import 'package:wasla/core/database/api/api_consumer.dart';
import 'package:wasla/core/database/api/api_end_points.dart';
import 'package:wasla/core/database/api/api_interceptors.dart';
import 'package:wasla/core/database/api/errors/api_exceptions.dart';
import 'package:wasla/core/database/api/errors/error_model.dart';

class DioConsumer extends ApiConsumer {
  final Dio dio;

  DioConsumer({required this.dio}) {
    dio.options.baseUrl = ApiEndPoints.baseUrl;
    dio.interceptors.add(ApiInterceptors());
  }

  @override
  Future delete(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await dio.delete(
        path,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (dioError) {
      handleDioExceptions(dioError);
    } catch (e) {
      throw ServerException(errorModel: ErrorModel(errorMessage: e.toString()));
    }
  }

  @override
  Future get(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await dio.get(
        path,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (dioError) {
      handleDioExceptions(dioError);
    } catch (e) {
      throw ServerException(errorModel: ErrorModel(errorMessage: e.toString()));
    }
  }

  @override
  Future patch(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await dio.patch(
        path,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (dioError) {
      handleDioExceptions(dioError);
    } catch (e) {
      throw ServerException(errorModel: ErrorModel(errorMessage: e.toString()));
    }
  }

  @override
  Future post(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await dio.post(
        path,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (dioError) {
      handleDioExceptions(dioError);
    } catch (e) {
      throw ServerException(errorModel: ErrorModel(errorMessage: e.toString()));
    }
  }

  @override
  Future put(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await dio.put(
        path,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (dioError) {
      handleDioExceptions(dioError);
    } catch (e) {
      throw ServerException(errorModel: ErrorModel(errorMessage: e.toString()));
    }
  }
}
