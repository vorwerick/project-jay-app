// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_registration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceRegistration _$DeviceRegistrationFromJson(Map<String, dynamic> json) =>
    DeviceRegistration(
      json['PreauthKey'] as String,
      json['DeviceKey'] as String,
    );

Map<String, dynamic> _$DeviceRegistrationToJson(DeviceRegistration instance) =>
    <String, dynamic>{
      'PreauthKey': instance.preauthKey,
      'DeviceKey': instance.deviceKey,
    };
