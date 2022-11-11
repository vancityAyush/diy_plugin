// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthBean _$AuthBeanFromJson(Map<String, dynamic> json) => AuthBean(
      Token: json['Token'] as String,
      RefreshToken: json['RefreshToken'] as String? ?? "",
      ExpiresIn: json['ExpiresIn'] as int,
    );

Map<String, dynamic> _$AuthBeanToJson(AuthBean instance) => <String, dynamic>{
      'Token': instance.Token,
      'RefreshToken': instance.RefreshToken,
      'ExpiresIn': instance.ExpiresIn,
    };
