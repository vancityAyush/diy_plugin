import 'package:diy/network/models/auth_token.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../diy.dart';

class Token {
  final storage = getIt<FlutterSecureStorage>();
  static const TOKEN = "token";
  static const REFRESH_TOKEN = "refresh_token";
  static const EXPIRES_IN = "expires_in";
  String? token;
  String? refreshToken;
  int? _expiresIn;

  int get expiresIn {
    return _expiresIn ?? 0;
  }

  void writeToken() async {
    await storage.write(key: TOKEN, value: token);
    await storage.write(key: REFRESH_TOKEN, value: refreshToken);
    await storage.write(key: EXPIRES_IN, value: expiresIn.toString());
  }

  void printToken() {
    print("Token: $token");
    print("Refresh Token: $refreshToken");
    print("Expires In: $expiresIn");
  }

  Future<bool> readToken() async {
    String? expiresIn = await storage.read(key: EXPIRES_IN);
    if (expiresIn != null) {
      if (DateTime.now().millisecondsSinceEpoch > int.parse(expiresIn)) {
        return false; // token expired
      }
    }
    token = await storage.read(key: TOKEN);
    refreshToken = await storage.read(key: REFRESH_TOKEN);
    printToken();
    return true;
  }

  setToken(AuthBean bean) {
    token = bean.Token;
    refreshToken = bean.RefreshToken;
    _expiresIn =
        DateTime.now().millisecondsSinceEpoch + (bean.ExpiresIn * 1000);
    writeToken();
    printToken();
  }

  bool isTokenValid() {
    return token != null && refreshToken != null && expiresIn != null;
  }

  bool get isExpired {
    return DateTime.now().millisecondsSinceEpoch > expiresIn!;
  }

  @override
  String toString() {
    return token ?? "";
  }
}
