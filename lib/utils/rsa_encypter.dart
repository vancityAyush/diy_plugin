import 'dart:convert';

import 'package:encrypt/encrypt.dart';
import 'package:flutter/services.dart';
import 'package:pointycastle/asymmetric/api.dart';

class RSAEncrypter {
  static final RSAEncrypter _singleton = RSAEncrypter._internal();
  late final RSAPublicKey publicKey;
  late final Encrypter encrypter;
  factory RSAEncrypter() {
    return _singleton;
  }

  RSAEncrypter._internal() {
    rootBundle.loadString('packages/diy/assets/pem/public.pem').then((value) {
      final parser = RSAKeyParser();
      publicKey = parser.parse(value) as RSAPublicKey;
      encrypter = Encrypter(RSA(publicKey: publicKey));
    });
  }

  init() async {
    // publicKey = await parseKeyFromFile<RSAPublicKey>('assets/public.pem');
    // encrypter = Encrypter(RSA(publicKey: publicKey));
  }

  String encrypt(String plainText) {
    return encrypter.encrypt(plainText).base64;
  }

  String encryptJson(Map<String, dynamic> json) {
    return encrypt(jsonEncode(json));
  }
}
