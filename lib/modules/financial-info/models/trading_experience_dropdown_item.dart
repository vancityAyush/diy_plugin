import 'package:json_annotation/json_annotation.dart';

part '../models/trading_experience_dropdown_item.g.dart';

@JsonSerializable()
class TradingExperienceDropdownItem {
  int TradingExperienceId;
  String TradingExperienceName;

  TradingExperienceDropdownItem(
      {required this.TradingExperienceId, required this.TradingExperienceName});

  factory TradingExperienceDropdownItem.fromJson(Map<String, dynamic> json) =>
      _$TradingExperienceDropdownItemFromJson(json);

  Map<String, dynamic> toJson() => _$TradingExperienceDropdownItemToJson(this);
}
