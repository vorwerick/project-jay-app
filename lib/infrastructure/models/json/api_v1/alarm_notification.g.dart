// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarm_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlarmNotification _$AlarmNotificationFromJson(Map<String, dynamic> json) =>
    AlarmNotification(
      eventId: json['EventId'] as int,
      notificationType: json['NotificationType'] as int,
      deviceKey: json['DeviceKey'] as String,
    );

Map<String, dynamic> _$AlarmNotificationToJson(AlarmNotification instance) =>
    <String, dynamic>{
      'EventId': instance.eventId,
      'NotificationType': instance.notificationType,
      'DeviceKey': instance.deviceKey,
    };
