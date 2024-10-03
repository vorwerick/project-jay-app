// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unit_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnitDetail _$UnitDetailFromJson(Map<String, dynamic> json) => UnitDetail(
      (json['ErrorCode'] as num).toInt(),
      json['Description'] as String?,
      json['unitDetail'] == null
          ? null
          : Detail.fromJson(json['unitDetail'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UnitDetailToJson(UnitDetail instance) =>
    <String, dynamic>{
      'ErrorCode': instance.errorCode,
      'Description': instance.description,
      'unitDetail': instance.unitDetail,
    };

Detail _$DetailFromJson(Map<String, dynamic> json) => Detail(
      (json['Id'] as num).toInt(),
      json['GroupName'] as String,
      json['GroupNumber'] as String,
      Gps.fromJson(json['FiraStationGps'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DetailToJson(Detail instance) => <String, dynamic>{
      'Id': instance.id,
      'GroupName': instance.groupName,
      'GroupNumber': instance.GroupNumber,
      'FiraStationGps': instance.firaStationGps,
    };
