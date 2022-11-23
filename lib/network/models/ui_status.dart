import 'package:json_annotation/json_annotation.dart';

part 'ui_status.g.dart';

@JsonSerializable()
class UiStatus {
  int NextModuleId;
  List<int> BackMenuList;

  UiStatus({required this.NextModuleId, required this.BackMenuList});

  factory UiStatus.fromJson(Map<String, dynamic> json) =>
      _$UiStatusFromJson(json);

  Map<String, dynamic> toJson() => _$UiStatusToJson(this);

  String get currentRoute => modules[NextModuleId] ?? "/";

  Map<int, String> titles = {
    1: "Verify Mobile",
    2: "Email",
    3: "Verify Email",
    4: "PAN",
    35: "KRA",
    5: "IFSC",
    18: "Address Proof Front Side",
  };

  Map<int, String> modules = {
    1: "/verify-mobile",
    2: "/form/email",
    3: "/form/verify-email",
    4: "/form/pan",
    35: "/form/kra",
    5: "/form/bank-ifsc-code",
    18: "/form/address-proof-front-side"
  };
}