// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'func.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Func _$FuncFromJson(Map<String, dynamic> json) => Func(
      id: (json['Id'] as num).toInt(),
      functionName: json['FunctionName'] as String,
      fireSystem: json['FireSystem'] as bool,
      functionIndex: (json['FunctionIndex'] as num).toInt(),
    );

Map<String, dynamic> _$FuncToJson(Func instance) => <String, dynamic>{
      'Id': instance.id,
      'FunctionName': instance.functionName,
      'FireSystem': instance.fireSystem,
      'FunctionIndex': instance.functionIndex,
    };
