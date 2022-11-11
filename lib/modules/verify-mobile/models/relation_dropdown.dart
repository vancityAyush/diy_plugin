import 'package:json_annotation/json_annotation.dart';

part 'relation_dropdown.g.dart';

@JsonSerializable()
class RelationDropdown {
  int RelationId;
  String RelationCode;
  String RelationName;

  RelationDropdown(
      {required this.RelationId,
      required this.RelationCode,
      required this.RelationName});

  factory RelationDropdown.fromJson(Map<String, dynamic> json) =>
      _$RelationDropdownFromJson(json);

  Map<String, dynamic> toJson() => _$RelationDropdownToJson(this);
}
