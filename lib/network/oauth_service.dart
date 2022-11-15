import 'dart:async';

import 'package:diy/network/http_client.dart';
import 'package:diy/network/models/token.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'models/Response.dart';
import 'models/auth_token.dart';
import 'models/user.dart';

class OAuthService {
  final HttpClient _http;
  final FlutterSecureStorage _storage;
  final dummyUser = User();

  Token token = Token();

  OAuthService(this._http, this._storage);

  StreamController<User?> userController = StreamController<User>();
  dynamic currentUser;
  dynamic response;

  Stream<User?> get authStateChange {
    return userController.stream;
  }

  Future<void> initState() async {
    // bool isTokenValid = await token.readToken();
    if (kDebugMode) {
      await sendOtp("8084100105");
      await verifyOtp("1234");
    }
  }

  Future<dynamic> logout() async {
    await _storage.deleteAll();
    userController.add(dummyUser);
    await _http.get("/app/logout/");
  }

  Future<void> refreshToken() async {
    try {
      final res = await _http.post("/auth/refresh/", data: {
        "RefreshToken": token.refreshToken,
        "Token": token.token,
      });
      token.setToken(AuthBean.fromJson(res));
    } on HttpException catch (e) {
      print(e);
      await logout();
      //TODO NAVIGATE TO LOGIN PAGE
    }
  }

  Future<ResponseModel> sendOtp(String phone) async {
    try {
      response = await startAuth(phone);
      if (response != null) {
        return ResponseModel(
          success: true,
          message: "OTP sent successfully",
        );
      } else {
        return ResponseModel(success: false, message: "Error sending OTP");
      }
    } catch (e) {
      print(e);
      return ResponseModel(success: false, message: e);
    }
  }

  Future<ResponseModel> verifyOtp(String otp, {int relationId = 1}) async {
    try {
      User user = await verifyAuth(response["Mobile"], otp, response["RefId"],
          relationshipId: relationId);
      currentUser = user;
      token.setToken(user.Auth!);
      return ResponseModel(success: true, message: "User Verified");
    } catch (e) {
      print(e);
      return ResponseModel(success: false, message: e);
    }
  }

  Future<dynamic> startAuth(String mobile) async {
    try {
      final response = await _http.postEncrypted(
        "/auth/start/",
        data: {"Mobile": mobile, "Source": 1, "IsEnableWhatsApp": true},
      );
      return response;
    } on HttpException catch (e) {
      print(e);
      Get.snackbar("Error", e.cause);
    }
  }

  Future<User> verifyAuth(String mobile, String code, String refId,
      {int relationshipId = 1}) async {
    final response = await _http.post(
      "/auth/validate-mobile/",
      data: {
        "Source": 1,
        "IsLpRedirect": false,
        "Mobile": mobile,
        "AppExists": true,
        "RefId": refId,
        "MobileRelationshipId": relationshipId,
        "Otp": code
      },
    );
    return User.fromJson(response);
  }
}
