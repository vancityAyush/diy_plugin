import 'package:json_annotation/json_annotation.dart';

part 'income_dropdown_item.g.dart';

@JsonSerializable()
class IncomeProofDropdownItem {
  int IncomeDocumentId;
  String DocumentName;

  IncomeProofDropdownItem(
      {required this.IncomeDocumentId, required this.DocumentName});

  factory IncomeProofDropdownItem.fromJson(Map<String, dynamic> json) =>
      _$IncomeProofDropdownItemFromJson(json);

  Map<String, dynamic> toJson() => _$IncomeProofDropdownItemToJson(this);
}
