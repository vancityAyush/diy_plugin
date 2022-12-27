import 'package:json_annotation/json_annotation.dart';

part 'plan.g.dart';

@JsonSerializable()
class plan {
  int PlanId;
  String Source;
  String Name;
  String Title;
  String Description;
  List<String> Features;

  plan(
      {required this.PlanId,
      required this.Source,
      required this.Name,
      required this.Title,
      required this.Description,
      required this.Features});

  factory plan.fromJson(Map<String, dynamic> json) => _$planFromJson(json);

  Map<String, dynamic> toJson() => _$planToJson(this);
}
