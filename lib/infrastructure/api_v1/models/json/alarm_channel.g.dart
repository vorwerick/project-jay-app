// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarm_channel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlarmChannel _$AlarmChannelFromJson(Map<String, dynamic> json) => AlarmChannel(
      json['AlarmChannel'] as String,
      json['DeviceKey'] as String,
    );

Map<String, dynamic> _$AlarmChannelToJson(AlarmChannel instance) =>
    <String, dynamic>{
      'AlarmChannel': instance.alarmChannel,
      'DeviceKey': instance.deviceKey,
    };
