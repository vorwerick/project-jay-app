// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarm_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlarmNotification _$AlarmNotificationFromJson(Map<String, dynamic> json) =>
    AlarmNotification(
      eventId: (json['EventId'] as num).toInt(),
      notificationType: (json['NotificationType'] as num).toInt(),
      deviceKey: json['DeviceKey'] as String,
    );

Map<String, dynamic> _$AlarmNotificationToJson(AlarmNotification instance) =>
    <String, dynamic>{
      'EventId': instance.eventId,
      'NotificationType': instance.notificationType,
      'DeviceKey': instance.deviceKey,
    };
