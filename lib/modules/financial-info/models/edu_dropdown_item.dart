import 'package:json_annotation/json_annotation.dart';

part 'edu_dropdown_item.g.dart';

@JsonSerializable()
class CountryDropdownItem {
  int CountryId;
  String CountryName;
  String? CountryCode;

  CountryDropdownItem(
      {required this.CountryId, required this.CountryName, this.CountryCode});

  factory CountryDropdownItem.fromJson(Map<String, dynamic> json) =>
      _$CountryDropdownItemFromJson(json);

  Map<String, dynamic> toJson() => _$CountryDropdownItemToJson(this);
}
