import 'package:json_annotation/json_annotation.dart';

part 'auth_token.g.dart';

@JsonSerializable()
class AuthBean {
  String Token;
  final String RefreshToken;
  int ExpiresIn;

  AuthBean({
    required this.Token,
    this.RefreshToken = "",
    required this.ExpiresIn,
  });

  factory AuthBean.fromJson(Map<String, dynamic> json) =>
      _$AuthBeanFromJson(json);

  Map<String?, dynamic> toJson() => _$AuthBeanToJson(this);
}
