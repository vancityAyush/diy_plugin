import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:diy/network/auth_interceptor.dart';
import 'package:diy/utils/util.dart';

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

  Future<dynamic> getImage(String endPoint) async {
    final res = await _dio.download(
      endPoint,
      "/bankProof.png",
    );
    return res.data;
  }

  Future<dynamic> get(
    String endPoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      var response = await _dio.get(endPoint, queryParameters: queryParameters);

      return response.data;
    } on DioError catch (e) {
      final String? res = e.response!.data["ErrorMessage"];
      AppUtil.showErrorToast(res ?? "Something Went Wrong!");
      throw HttpException(e.message, e.response);
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
      final String? res = e.response!.data["ErrorMessage"];
      AppUtil.showErrorToast(res ?? "Something Went Wrong!");
      throw HttpException(e.message, e.response);
    } on Exception catch (e) {
      throw HttpException("Error", e);
    }
  }

  Future<dynamic> postEncrypted(
    String endPoint, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    print("dataEncrypted: $data");
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
      throw HttpException(e.message, e.response);
    }
  }
}

class HttpException implements Exception {
  String cause;
  dynamic error;
  HttpException(this.cause, this.error);

  @override
  String toString() {
    return cause;
  }
}
