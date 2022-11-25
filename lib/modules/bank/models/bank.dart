import 'package:json_annotation/json_annotation.dart';

part 'bank.g.dart';

@JsonSerializable()
class bank {
  int BankId;
  String? DSACode;
  int CreatedBy;
  int ModifiedBy;
  String Bank;
  String Branch;
  String BranchCode;
  String Address;
  String Std_Code;
  String Contact;
  String City;
  String District;
  String State;
  String IFSC;
  String MICR_CODE;

  bank(
      {required this.BankId,
      required this.DSACode,
      required this.CreatedBy,
      required this.ModifiedBy,
      required this.Bank,
      required this.Branch,
      required this.BranchCode,
      required this.Address,
      required this.Std_Code,
      required this.Contact,
      required this.City,
      required this.District,
      required this.State,
      required this.IFSC,
      required this.MICR_CODE});

  factory bank.fromJson(Map<String, dynamic> json) => _$bankFromJson(json);

  Map<String, dynamic> toJson() => _$bankToJson(this);
}
