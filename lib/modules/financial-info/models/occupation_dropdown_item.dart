import 'package:json_annotation/json_annotation.dart';

part '../models/occupation_dropdown_item.g.dart';

@JsonSerializable()
class OccupationDropdownItem {
  int OccupationId;
  String OccupationName;

  OccupationDropdownItem(
      {required this.OccupationId, required this.OccupationName});

  factory OccupationDropdownItem.fromJson(Map<String, dynamic> json) =>
      _$OccupationDropdownItemFromJson(json);

  Map<String, dynamic> toJson() => _$OccupationDropdownItemToJson(this);
}
