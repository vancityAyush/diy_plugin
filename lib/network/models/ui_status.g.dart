// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ui_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UiStatus _$UiStatusFromJson(Map<String, dynamic> json) => UiStatus(
      NextModuleId: json['NextModuleId'] as int,
      BackMenuList:
          (json['BackMenuList'] as List<dynamic>).map((e) => e as int).toList(),
    )
      ..titles = (json['titles'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(int.parse(k), e as String),
      )
      ..modules = (json['modules'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(int.parse(k), e as String),
      );

Map<String, dynamic> _$UiStatusToJson(UiStatus instance) => <String, dynamic>{
      'NextModuleId': instance.NextModuleId,
      'BackMenuList': instance.BackMenuList,
      'titles': instance.titles.map((k, e) => MapEntry(k.toString(), e)),
      'modules': instance.modules.map((k, e) => MapEntry(k.toString(), e)),
    };
