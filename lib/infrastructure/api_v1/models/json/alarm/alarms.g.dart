// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarms.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Alarms _$AlarmsFromJson(Map<String, dynamic> json) => Alarms(
      (json['ErrorCode'] as num).toInt(),
      json['Description'] as String?,
      json['Alarm'] == null
          ? null
          : Alarm.fromJson(json['Alarm'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AlarmsToJson(Alarms instance) => <String, dynamic>{
      'ErrorCode': instance.errorCode,
      'Description': instance.description,
      'Alarm': instance.alarm,
    };
