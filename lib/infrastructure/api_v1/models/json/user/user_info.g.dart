// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
      userData: UserInfo.fromJson(json['Data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      'Data': instance.userData,
    };

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) => UserInfo(
      id: json['Id'] as int?,
      name: json['Name'] as String,
      surname: json['Surname'] as String,
      title: json['Title'] as String,
      phoneNumber: json['PhoneNumber'] as String,
    );

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'Id': instance.id,
      'Name': instance.name,
      'Surname': instance.surname,
      'Title': instance.title,
      'PhoneNumber': instance.phoneNumber,
    };
