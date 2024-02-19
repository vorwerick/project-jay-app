import 'package:app/infrastructure/api_v1/models/json/fleet.dart';
import 'package:app/infrastructure/api_v1/models/json/gps.dart';
import 'package:json_annotation/json_annotation.dart';

part 'alarm.g.dart';

@JsonSerializable()
class Alarm {
  @JsonKey(name: 'UnitFleet')
  final List<Fleet>? unitFleet;

  @JsonKey(name: 'OtherFleet')
  final List<Fleet>? otherFleet;

  @JsonKey(name: 'ConfirmCount')
  final int? confirmCount;

  @JsonKey(name: 'DeclineCount')
  final int? declineCount;

  @JsonKey(name: 'EventId')
  final int eventId;

  @JsonKey(name: 'AlarmState')
  final int alarmState;

  @JsonKey(name: 'OrderSent')
  final DateTime orderSent;

  @JsonKey(name: 'OrderUpdate')
  final DateTime orderUpdate;

  @JsonKey(name: 'AlarmTitle')
  final String alarmTile;

  @JsonKey(name: 'AlarmPreview')
  final String alarmPreview;

  @JsonKey(name: 'AlarmLevel')
  final int alarmLevel;

  @JsonKey(name: 'Gps')
  final Gps gps;

  @JsonKey(name: 'MapZoom')
  final double? mapZoom;

  @JsonKey(name: 'UnitName')
  final String unitName;

  @JsonKey(name: 'UnitIdentificationNumber')
  final String unitIdentificationNumber;

  @JsonKey(name: 'UnitType')
  final String unitType;

  @JsonKey(name: 'EventType')
  final String eventType;

  @JsonKey(name: 'Region')
  final String region;

  @JsonKey(name: 'District')
  final String district;

  @JsonKey(name: 'City')
  final String city;

  @JsonKey(name: 'CitySector')
  final String citySector;

  @JsonKey(name: 'Street')
  final String street;

  @JsonKey(name: 'Num1')
  final String num1;

  @JsonKey(name: 'Num2')
  final String num2;

  @JsonKey(name: 'OrderObject')
  final String orderObject;

  @JsonKey(name: 'OrderType')
  final int orderType;

  @JsonKey(name: 'Technic')
  final String technic;

  @JsonKey(name: 'Info')
  final String info;

  @JsonKey(name: 'Floor')
  final String floor;

  @JsonKey(name: 'Clarification')
  final String clarification;

  @JsonKey(name: 'WhatHappened')
  final String whatHappened;

  @JsonKey(name: 'Announced')
  final String announced;

  @JsonKey(name: 'AnnouncedPhone')
  final String announcedPhone;

  @JsonKey(name: 'EventAddress')
  final String eventAddress;

  @JsonKey(name: 'CurrentUserConfirm')
  final bool? currentUserConfirm;

  factory Alarm.fromJson(Map<String, dynamic> json) => _$AlarmFromJson(json);

  Alarm(
    this.confirmCount,
    this.declineCount,
    this.eventId,
    this.alarmState,
    this.orderSent,
    this.orderUpdate,
    this.alarmTile,
    this.alarmPreview,
    this.alarmLevel,
    this.gps,
    this.mapZoom,
    this.unitName,
    this.unitIdentificationNumber,
    this.unitType,
    this.eventType,
    this.region,
    this.district,
    this.city,
    this.citySector,
    this.street,
    this.num1,
    this.num2,
    this.orderObject,
    this.orderType,
    this.technic,
    this.info,
    this.floor,
    this.clarification,
    this.whatHappened,
    this.announced,
    this.announcedPhone,
    this.eventAddress,
    this.currentUserConfirm,
    this.unitFleet,
    this.otherFleet,
  );

  Map<String, dynamic> toJson() => _$AlarmToJson(this);
}
