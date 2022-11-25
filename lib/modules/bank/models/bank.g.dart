// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

bank _$bankFromJson(Map<String, dynamic> json) => bank(
      BankId: json['BankId'] as int,
      DSACode: json['DSACode'] as String?,
      CreatedBy: json['CreatedBy'] as int,
      ModifiedBy: json['ModifiedBy'] as int,
      Bank: json['Bank'] as String,
      Branch: json['Branch'] as String,
      BranchCode: json['BranchCode'] as String,
      Address: json['Address'] as String,
      Std_Code: json['Std_Code'] as String,
      Contact: json['Contact'] as String,
      City: json['City'] as String,
      District: json['District'] as String,
      State: json['State'] as String,
      IFSC: json['IFSC'] as String,
      MICR_CODE: json['MICR_CODE'] as String,
    );

Map<String, dynamic> _$bankToJson(bank instance) => <String, dynamic>{
      'BankId': instance.BankId,
      'DSACode': instance.DSACode,
      'CreatedBy': instance.CreatedBy,
      'ModifiedBy': instance.ModifiedBy,
      'Bank': instance.Bank,
      'Branch': instance.Branch,
      'BranchCode': instance.BranchCode,
      'Address': instance.Address,
      'Std_Code': instance.Std_Code,
      'Contact': instance.Contact,
      'City': instance.City,
      'District': instance.District,
      'State': instance.State,
      'IFSC': instance.IFSC,
      'MICR_CODE': instance.MICR_CODE,
    };
