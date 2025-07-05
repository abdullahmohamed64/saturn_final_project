import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:saturn/core/helper/app_functions.dart';
import 'package:saturn/core/networking/api%20consumer/api_consumer.dart';
import 'package:saturn/core/networking/api_error_model.dart';
import 'package:saturn/core/networking/server_exception.dart';

class DioConsumer extends ApiConsumer {
  final Dio dio;

  DioConsumer({required this.dio});
  @override
  Future delete(
    String path, {
    dynamic data,
    bool isFromData = false,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final res = await dio.delete(
        path,
        queryParameters: queryParameters,
        data: isFromData ? FormData.fromMap(data) : data,
      );
      final Map<String, dynamic> jsonResponse =
          res is String ? json.decode(res.data) : res.data;
      return jsonResponse;
    } on DioException catch (e) {
      AppFunctions.handleException(e);
    } catch (e) {
      throw ServerException(
        apiErrorModel: ApiErrorModel(message: 'an error has occured'),
      );
    }
  }

  @override
  Future get(
    String path, {
    Map<String, dynamic>? data,
    bool isFromData = false,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final res = await dio.get(
        path,
        data: isFromData ? FormData.fromMap(data ?? {}) : data,
        queryParameters: queryParameters,
      );
      final Map<String, dynamic> jsonResponse = json.decode(res.data);
      return jsonResponse;
    } on DioException catch (e) {
      AppFunctions.handleException(e);
    }
  }

  @override
  Future patch(
    String path, {
    dynamic data,
    bool isFromData = false,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final res = await dio.patch(
        path,
        data: isFromData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      final Map<String, dynamic> jsonResponse =
          res is String ? json.decode(res.data) : res.data;
      return jsonResponse;
    } on DioException catch (e) {
      AppFunctions.handleException(e);
    } catch (e) {
      throw ServerException(
        apiErrorModel: ApiErrorModel(message: 'an error has occured'),
      );
    }
  }

  @override
  Future post(
    String path, {
    data,
    bool isFromData = false,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final res = await dio.post(
        path,
        data: isFromData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      final Map<String, dynamic> jsonResponse = jsonDecode(res.data);

      return jsonResponse;
    } on DioException catch (e) {
      AppFunctions.handleException(e);
    }
    //catch (e) {
    //   throw ServerException(
    //     apiErrorModel: ApiErrorModel(message: 'an error has occured'),
    //   );
    // }
  }

  @override
  Future put(
    String path, {
    data,
    bool isFromData = false,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final res = await dio.put(
        path,
        data: isFromData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );

      final Map<String, dynamic> jsonResponse =
          res is String ? json.decode(res.data) : res.data;
      return jsonResponse;
    } on DioException catch (e) {
      AppFunctions.handleException(e);
    } catch (e) {
      throw ServerException(
        apiErrorModel: ApiErrorModel(message: 'an error has occured'),
      );
    }
  }
}
