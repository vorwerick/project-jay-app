import 'package:json_annotation/json_annotation.dart';

part 'alarm_notification.g.dart';

@JsonSerializable()
class AlarmNotification {
  @JsonKey(name: 'EventId')
  final int eventId;

  @JsonKey(name: 'NotificationType')
  final int notificationType;

  @JsonKey(name: 'DeviceKey')
  final String deviceKey;

  AlarmNotification({required this.eventId, required this.notificationType, required this.deviceKey});

  factory AlarmNotification.fromJson(Map<String, dynamic> json) => _$AlarmNotificationFromJson(json);

  Map<String, dynamic> toJson() => _$AlarmNotificationToJson(this);
}
