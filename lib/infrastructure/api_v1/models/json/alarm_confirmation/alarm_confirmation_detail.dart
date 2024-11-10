import 'package:app/infrastructure/api_v1/models/json/api_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'alarm_confirmation_detail.g.dart';

@JsonSerializable()
final class AlarmConfirmationDetail extends ApiResponse {
  @JsonKey(name: 'AlarmConfirmation')
  final AlarmConfirmationInfo? alarmConfirmation;

  AlarmConfirmationDetail(super.errorCode, super.description, this.alarmConfirmation);

  factory AlarmConfirmationDetail.fromJson(Map<String, dynamic> json) => _$AlarmConfirmationDetailFromJson(json);

  Map<String, dynamic> toJson() => _$AlarmConfirmationDetailToJson(this);
}

@JsonSerializable()
final class AlarmConfirmationInfo {
  @JsonKey(name: 'EventId')
  final int eventId;
  @JsonKey(name: 'AlarmState')
  final int alarmState;
  @JsonKey(name: 'AlarmMembers')
  final List<AlarmMember> alarmMembers;

  AlarmConfirmationInfo(this.eventId, this.alarmState, this.alarmMembers);

  factory AlarmConfirmationInfo.fromJson(Map<String, dynamic> json) => _$AlarmConfirmationInfoFromJson(json);

  Map<String, dynamic> toJson() => _$AlarmConfirmationInfoToJson(this);
}

@JsonSerializable()
final class AlarmMember {
  @JsonKey(name: 'MemberId')
  final int memberId;
  @JsonKey(name: 'FirstName')
  final String firstName;
  @JsonKey(name: 'LastName')
  final String lastName;
  @JsonKey(name: 'MemberFunction')
  final int memberFunction;
  @JsonKey(name: 'MemberFunctionText')
  final String memberFunctionText;
  @JsonKey(name: 'ConfirmDate')
  final DateTime confirmDate;
  @JsonKey(name: 'ConfirmAlarm')
  final bool confirmAlarm;

  AlarmMember(this.memberId, this.firstName, this.lastName, this.memberFunction, this.memberFunctionText,
      this.confirmDate, this.confirmAlarm,);

  factory AlarmMember.fromJson(Map<String, dynamic> json) => _$AlarmMemberFromJson(json);

  Map<String, dynamic> toJson() => _$AlarmMemberToJson(this);
}
