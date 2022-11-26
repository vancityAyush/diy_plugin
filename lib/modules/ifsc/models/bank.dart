import 'package:json_annotation/json_annotation.dart';

part 'bank.g.dart';

@JsonSerializable()
class bank {
  int BankId;
  String? DSACode;
  String Bank;
  String Branch;
  String? BranchCode;
  String? Address;
  String? Std_Code;
  String? Contact;
  String? City;
  String? District;
  String? State;
  String? IFSC;
  String? MICR_CODE;

  bank(
      {required this.BankId,
      this.DSACode,
      required this.Bank,
      required this.Branch,
      this.BranchCode,
      this.Address,
      this.Std_Code,
      this.Contact,
      this.City,
      this.District,
      this.State,
      this.IFSC,
      this.MICR_CODE});

  factory bank.fromJson(Map<String, dynamic> json) => _$bankFromJson(json);

  Map<String, dynamic> toJson() => _$bankToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is bank &&
          runtimeType == other.runtimeType &&
          BankId == other.BankId;
}
