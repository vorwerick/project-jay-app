// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_registration_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceRegistrationDetail _$DeviceRegistrationDetailFromJson(
        Map<String, dynamic> json) =>
    DeviceRegistrationDetail(
      json['ErrorCode'] as int,
      json['Description'] as String?,
      json['topic'] as String?,
    );

Map<String, dynamic> _$DeviceRegistrationDetailToJson(
        DeviceRegistrationDetail instance) =>
    <String, dynamic>{
      'ErrorCode': instance.errorCode,
      'Description': instance.description,
      'topic': instance.topic,
    };
