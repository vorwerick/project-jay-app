import 'package:app/infrastructure/models/json/api_v1/alarm.dart';
import 'package:app/infrastructure/models/json/api_v1/api_response.dart';
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
