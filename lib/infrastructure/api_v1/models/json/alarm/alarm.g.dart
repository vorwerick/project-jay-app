// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Alarm _$AlarmFromJson(Map<String, dynamic> json) => Alarm(
      json['ConfirmCount'] as int?,
      json['DeclineCount'] as int?,
      json['EventId'] as int,
      json['AlarmState'] as int,
      DateTime.parse(json['OrderSent'] as String),
      DateTime.parse(json['OrderUpdate'] as String),
      json['AlarmTitle'] as String,
      json['AlarmPreview'] as String,
      json['AlarmLevel'] as int,
      Gps.fromJson(json['Gps'] as Map<String, dynamic>),
      (json['MapZoom'] as num?)?.toDouble(),
      json['UnitName'] as String,
      json['UnitIdentificationNumber'] as String,
      json['UnitType'] as String,
      json['EventType'] as String,
      json['Region'] as String,
      json['District'] as String,
      json['City'] as String,
      json['CitySector'] as String,
      json['Street'] as String,
      json['Num1'] as String,
      json['Num2'] as String,
      json['OrderObject'] as String,
      json['OrderType'] as int,
      json['Technic'] as String,
      json['Info'] as String,
      json['Floor'] as String,
      json['Clarification'] as String,
      json['WhatHappened'] as String,
      json['Announced'] as String,
      json['AnnouncedPhone'] as String,
      json['EventAddress'] as String,
      json['CurrentUserConfirm'] as bool?,
      (json['UnitFleet'] as List<dynamic>?)
          ?.map((e) => Fleet.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['OtherFleet'] as List<dynamic>?)
          ?.map((e) => Fleet.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AlarmToJson(Alarm instance) => <String, dynamic>{
      'UnitFleet': instance.unitFleet,
      'OtherFleet': instance.otherFleet,
      'ConfirmCount': instance.confirmCount,
      'DeclineCount': instance.declineCount,
      'EventId': instance.eventId,
      'AlarmState': instance.alarmState,
      'OrderSent': instance.orderSent.toIso8601String(),
      'OrderUpdate': instance.orderUpdate.toIso8601String(),
      'AlarmTitle': instance.alarmTile,
      'AlarmPreview': instance.alarmPreview,
      'AlarmLevel': instance.alarmLevel,
      'Gps': instance.gps,
      'MapZoom': instance.mapZoom,
      'UnitName': instance.unitName,
      'UnitIdentificationNumber': instance.unitIdentificationNumber,
      'UnitType': instance.unitType,
      'EventType': instance.eventType,
      'Region': instance.region,
      'District': instance.district,
      'City': instance.city,
      'CitySector': instance.citySector,
      'Street': instance.street,
      'Num1': instance.num1,
      'Num2': instance.num2,
      'OrderObject': instance.orderObject,
      'OrderType': instance.orderType,
      'Technic': instance.technic,
      'Info': instance.info,
      'Floor': instance.floor,
      'Clarification': instance.clarification,
      'WhatHappened': instance.whatHappened,
      'Announced': instance.announced,
      'AnnouncedPhone': instance.announcedPhone,
      'EventAddress': instance.eventAddress,
      'CurrentUserConfirm': instance.currentUserConfirm,
    };
