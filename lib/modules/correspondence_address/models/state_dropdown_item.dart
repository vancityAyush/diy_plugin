import 'package:json_annotation/json_annotation.dart';

part 'state_dropdown_item.g.dart';

@JsonSerializable()
class StateDropdownItem {
  int StateId;
  String StateName;
  String? StateCode;

  StateDropdownItem(
      {required this.StateId, required this.StateName, this.StateCode});

  factory StateDropdownItem.fromJson(Map<String, dynamic> json) =>
      _$StateDropdownItemFromJson(json);

  Map<String, dynamic> toJson() => _$StateDropdownItemToJson(this);
}
