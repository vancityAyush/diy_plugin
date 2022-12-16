import 'package:json_annotation/json_annotation.dart';

part 'income_dropdown_item.g.dart';

@JsonSerializable()
class AnnualIncomeDropdownItem {
  int AnnualIncomeId;
  String AnnualIncomeName;

  AnnualIncomeDropdownItem(
      {required this.AnnualIncomeId, required this.AnnualIncomeName});

  factory AnnualIncomeDropdownItem.fromJson(Map<String, dynamic> json) =>
      _$AnnualIncomeDropdownItemFromJson(json);

  Map<String, dynamic> toJson() => _$AnnualIncomeDropdownItemToJson(this);
}
