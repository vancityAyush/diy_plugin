// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

plan _$planFromJson(Map<String, dynamic> json) => plan(
      PlanId: json['PlanId'] as int,
      Source: json['Source'] as String,
      Name: json['Name'] as String,
      Title: json['Title'] as String,
      Description: json['Description'] as String,
      Features:
          (json['Features'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$planToJson(plan instance) => <String, dynamic>{
      'PlanId': instance.PlanId,
      'Source': instance.Source,
      'Name': instance.Name,
      'Title': instance.Title,
      'Description': instance.Description,
      'Features': instance.Features,
    };
