// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state_dropdown_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StateDropdownItem _$StateDropdownItemFromJson(Map<String, dynamic> json) =>
    StateDropdownItem(
      StateId: json['StateId'] as int,
      StateName: json['StateName'] as String,
      StateCode: json['StateCode'] as String?,
    );

Map<String, dynamic> _$StateDropdownItemToJson(StateDropdownItem instance) =>
    <String, dynamic>{
      'StateId': instance.StateId,
      'StateName': instance.StateName,
      'StateCode': instance.StateCode,
    };
