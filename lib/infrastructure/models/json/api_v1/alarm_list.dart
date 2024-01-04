import 'package:app/infrastructure/models/json/api_v1/alarm.dart';
import 'package:app/infrastructure/models/json/api_v1/api_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'alarm_list.g.dart';

@JsonSerializable()
class AlarmList extends ApiResponse {
  @JsonKey(name: 'Alarms')
  final List<Alarm>? alarms;

  AlarmList(super.errorCode, super.description, this.alarms);

  factory AlarmList.fromJson(Map<String, dynamic> json) => _$AlarmListFromJson(json);

  Map<String, dynamic> toJson() => _$AlarmListToJson(this);
}
