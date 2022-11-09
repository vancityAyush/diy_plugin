import 'dart:convert';

import 'package:diy/network/auth_interceptor.dart';
import 'package:dio/dio.dart';

import '../utils/rsa_encypter.dart';

class HttpClient {
  late final Dio _dio;
  final String baseUrl;
  final RSAEncrypter rsaEncrypter = RSAEncrypter();

  HttpClient(this.baseUrl) {
    var options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 20000,
      receiveTimeout: 20000,
    );

    _dio = Dio(options);
    _dio.interceptors.addAll(
      [
        LogInterceptor(
          requestBody: true,
          responseBody: true,
        ),
        AuthInterceptor(),
      ],
    );
  }

  Future<dynamic> get(
    String endPoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      var response = await _dio.get(endPoint, queryParameters: queryParameters);

      return response.data;
    } on DioError catch (e) {
      print(e.message);
      throw HttpException(e.message);
    }
  }

  Future<dynamic> post(
    String endPoint, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    bool encodeJson = true,
  }) async {
    try {
      var response = await _dio.post(
        endPoint,
        options: Options(headers: headers),
        data: encodeJson ? jsonEncode(data) : data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioError catch (e) {
      print('Http Error ${e.response}');
      throw HttpException(e.message);
    }
  }

  Future<dynamic> postEncrypted(
    String endPoint, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    return post(
      endPoint,
      data: {
        'Data': rsaEncrypter.encrypt(jsonEncode(data)),
      },
      queryParameters: queryParameters,
      headers: headers,
    );
  }

  Future<dynamic> delete(
    String endPoint, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    bool encodeJson = true,
  }) async {
    try {
      var response = await _dio.delete(
        endPoint,
        options: Options(headers: headers),
        data: encodeJson ? jsonEncode(data) : data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioError catch (e) {
      throw HttpException(e.message);
    }
  }
}

class HttpException implements Exception {
  String cause;
  HttpException(this.cause);

  @override
  String toString() {
    return cause;
  }
}
