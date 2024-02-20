// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gps.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Gps _$GpsFromJson(Map<String, dynamic> json) => Gps(
      (json['X'] as num).toDouble(),
      (json['Y'] as num).toDouble(),
    );

Map<String, dynamic> _$GpsToJson(Gps instance) => <String, dynamic>{
      'X': instance.x,
      'Y': instance.y,
    };
