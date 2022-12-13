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

  @JsonKey(ignore: true)
  String get currentRoute => modules[NextModuleId] ?? "/";

  @JsonKey(ignore: true)
  Map<int, String> titles = {
    1: "Verify Mobile",
    2: "Email",
    3: "Verify Email",
    4: "PAN",
    35: "KRA",
    5: "IFSC",
    6: "Bank Details",
    7: "Bank Proof",
    10: "KYC",
    8: "Upload Pan Photo",
    18: "Address Proof Front Side",
    19: "Address Proof Back Side",
    15: "Correspondence Address",
    9: "Upload Signature",
    20: "Upload Selfie",
    27: "Derivative Proof"
  };
  @JsonKey(ignore: true)
  Map<int, String> modules = {
    1: "/verify-mobile",
    2: "/form/email",
    3: "/form/verify-email",
    4: '/app/validate-pan/',
    35: "/app/validate-kra/",
    5: "/form/bank-ifsc-code",
    6: "/form/bank-account-no",
    7: "/form/upload-bank-proof",
    10: "/form/kyc",
    8: "/form/upload-pan-photo",
    18: "/form/address-proof-front-side",
    19: "/form/address-proof-back-side",
    15: "/form/correspondence-address",
    9: "/form/upload-sign",
    20: "/form/upload-selfie",
    27: "/form/upload-derivative-proof"
  };
}
