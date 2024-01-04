// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fleet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Fleet _$FleetFromJson(Map<String, dynamic> json) => Fleet(
      json['UnitName'] as String,
      json['FleetName'] as String,
      json['FleetNickName'] as String,
    );

Map<String, dynamic> _$FleetToJson(Fleet instance) => <String, dynamic>{
      'UnitName': instance.unitName,
      'FleetName': instance.fleetName,
      'FleetNickName': instance.fleetNickName,
    };
