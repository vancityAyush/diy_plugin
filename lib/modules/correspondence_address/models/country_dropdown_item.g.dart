// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_dropdown_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryDropdownItem _$CountryDropdownItemFromJson(Map<String, dynamic> json) =>
    CountryDropdownItem(
      CountryId: json['CountryId'] as int,
      CountryName: json['CountryName'] as String,
      CountryCode: json['CountryCode'] as String?,
    );

Map<String, dynamic> _$CountryDropdownItemToJson(
        CountryDropdownItem instance) =>
    <String, dynamic>{
      'CountryId': instance.CountryId,
      'CountryName': instance.CountryName,
      'CountryCode': instance.CountryCode,
    };
