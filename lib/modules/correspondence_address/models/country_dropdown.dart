import 'package:json_annotation/json_annotation.dart';

part 'country_dropdown.g.dart';

@JsonSerializable()
class CountryDropdown {
  int CountryId;
  String CountryName;
  String CountryCode;

  CountryDropdown(
      {required this.CountryId,
      required this.CountryName,
      required this.CountryCode});

  factory CountryDropdown.fromJson(Map<String, List<dynamic>> json) =>
      _$CountryDropdownFromJson(json);

  Map<String, dynamic> toJson() => _$CountryDropdownToJson(this);
}
