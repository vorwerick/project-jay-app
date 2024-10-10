// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
      (json['ErrorCode'] as num).toInt(),
      json['Description'] as String?,
      userData: UserInfo.fromJson(json['Data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      'ErrorCode': instance.errorCode,
      'Description': instance.description,
      'Data': instance.userData,
    };

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) => UserInfo(
      id: (json['Id'] as num?)?.toInt(),
      name: json['Name'] as String,
      surname: json['Surname'] as String,
      title: json['Title'] as String,
      phoneNumber: json['PhoneNumber'] as String,
      function: Func.fromJson(json['Function'] as Map<String, dynamic>),
      email: json['EmailAlarm'] as String,
    );

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'Id': instance.id,
      'Name': instance.name,
      'Surname': instance.surname,
      'Title': instance.title,
      'PhoneNumber': instance.phoneNumber,
      'Function': instance.function,
      'EmailAlarm': instance.email,
    };
