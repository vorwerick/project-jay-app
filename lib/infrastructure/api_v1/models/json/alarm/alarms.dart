import 'package:app/infrastructure/api_v1/models/json/alarm/alarm.dart';
import 'package:app/infrastructure/api_v1/models/json/api_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'alarms.g.dart';

@JsonSerializable()
class Alarms extends ApiResponse {
  @JsonKey(name: 'Alarm')
  final Alarm? alarm;

  factory Alarms.fromJson(Map<String, dynamic> json) => _$AlarmsFromJson(json);

  Alarms(super.errorCode, super.description, this.alarm);

  Map<String, dynamic> toJson() => _$AlarmsToJson(this);
}
