// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_configuration_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceConfigurationDetail _$DeviceConfigurationDetailFromJson(
        Map<String, dynamic> json) =>
    DeviceConfigurationDetail(
      json['ErrorCode'] as int,
      json['Description'] as String,
      (json['Items'] as List<dynamic>?)
          ?.map((e) => Item.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DeviceConfigurationDetailToJson(
        DeviceConfigurationDetail instance) =>
    <String, dynamic>{
      'ErrorCode': instance.errorCode,
      'Description': instance.description,
      'Items': instance.items,
    };

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
      json['key'] as String,
      json['value'] as String,
    );

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'key': instance.key,
      'value': instance.value,
    };
