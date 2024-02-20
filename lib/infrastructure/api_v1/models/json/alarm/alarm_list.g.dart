// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarm_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlarmList _$AlarmListFromJson(Map<String, dynamic> json) => AlarmList(
      json['ErrorCode'] as int,
      json['Description'] as String?,
      (json['Alarms'] as List<dynamic>?)
          ?.map((e) => Alarm.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AlarmListToJson(AlarmList instance) => <String, dynamic>{
      'ErrorCode': instance.errorCode,
      'Description': instance.description,
      'Alarms': instance.alarms,
    };
