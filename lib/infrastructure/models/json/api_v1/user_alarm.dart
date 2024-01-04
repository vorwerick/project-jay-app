import 'package:json_annotation/json_annotation.dart';

part 'user_alarm.g.dart';

@JsonSerializable()
class UserAlarm {
  final String message;

  UserAlarm(this.message);

  factory UserAlarm.fromJson(Map<String, dynamic> json) => _$UserAlarmFromJson(json);

  Map<String, dynamic> toJson() => _$UserAlarmToJson(this);
}
