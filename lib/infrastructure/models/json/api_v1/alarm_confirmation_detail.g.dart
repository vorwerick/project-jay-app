// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarm_confirmation_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlarmConfirmationDetail _$AlarmConfirmationDetailFromJson(
        Map<String, dynamic> json) =>
    AlarmConfirmationDetail(
      json['ErrorCode'] as int,
      json['Description'] as String,
      json['AlarmConfirmation'] == null
          ? null
          : AlarmConfirmationInfo.fromJson(
              json['AlarmConfirmation'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AlarmConfirmationDetailToJson(
        AlarmConfirmationDetail instance) =>
    <String, dynamic>{
      'ErrorCode': instance.errorCode,
      'Description': instance.description,
      'AlarmConfirmation': instance.alarmConfirmation,
    };

AlarmConfirmationInfo _$AlarmConfirmationInfoFromJson(
        Map<String, dynamic> json) =>
    AlarmConfirmationInfo(
      json['EventId'] as int,
      json['AlarmState'] as int,
      (json['AlarmMembers'] as List<dynamic>)
          .map((e) => AlarmMember.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AlarmConfirmationInfoToJson(
        AlarmConfirmationInfo instance) =>
    <String, dynamic>{
      'EventId': instance.eventId,
      'AlarmState': instance.alarmState,
      'AlarmMembers': instance.alarmMembers,
    };

AlarmMember _$AlarmMemberFromJson(Map<String, dynamic> json) => AlarmMember(
      json['MemberId'] as int,
      json['FirstName'] as String,
      json['LastName'] as String,
      json['MemberFunction'] as int,
      json['MemberFunctionText'] as String,
      DateTime.parse(json['ConfirmDate'] as String),
      json['ConfirmAlarm'] as bool,
    );

Map<String, dynamic> _$AlarmMemberToJson(AlarmMember instance) =>
    <String, dynamic>{
      'MemberId': instance.memberId,
      'FirstName': instance.firstName,
      'LastName': instance.lastName,
      'MemberFunction': instance.memberFunction,
      'MemberFunctionText': instance.memberFunctionText,
      'ConfirmDate': instance.confirmDate.toIso8601String(),
      'ConfirmAlarm': instance.confirmAlarm,
    };
