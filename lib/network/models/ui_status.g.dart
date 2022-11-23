// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ui_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UiStatus _$UiStatusFromJson(Map<String, dynamic> json) => UiStatus(
      NextModuleId: json['NextModuleId'] as int,
      BackMenuList:
          (json['BackMenuList'] as List<dynamic>).map((e) => e as int).toList(),
    );

Map<String, dynamic> _$UiStatusToJson(UiStatus instance) => <String, dynamic>{
      'NextModuleId': instance.NextModuleId,
      'BackMenuList': instance.BackMenuList,
    };
