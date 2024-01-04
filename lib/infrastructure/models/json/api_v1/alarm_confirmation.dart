import 'package:json_annotation/json_annotation.dart';

part 'alarm_confirmation.g.dart';

@JsonSerializable()
class AlarmConfirmation {
  @JsonKey(name: 'EventId')
  final int eventId;

  @JsonKey(name: 'Action')
  final String action;

  AlarmConfirmation(this.eventId, this.action);

  factory AlarmConfirmation.fromJson(Map<String, dynamic> json) => _$AlarmConfirmationFromJson(json);

  Map<String, dynamic> toJson() => _$AlarmConfirmationToJson(this);
}
