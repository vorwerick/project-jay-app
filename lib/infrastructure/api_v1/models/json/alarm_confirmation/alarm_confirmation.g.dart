// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarm_confirmation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlarmConfirmation _$AlarmConfirmationFromJson(Map<String, dynamic> json) =>
    AlarmConfirmation(
      (json['EventId'] as num).toInt(),
      json['Action'] as String,
    );

Map<String, dynamic> _$AlarmConfirmationToJson(AlarmConfirmation instance) =>
    <String, dynamic>{
      'EventId': instance.eventId,
      'Action': instance.action,
    };
