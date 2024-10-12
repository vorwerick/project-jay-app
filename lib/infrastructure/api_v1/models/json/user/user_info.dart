import 'package:app/infrastructure/api_v1/models/json/api_response.dart';
import 'package:app/infrastructure/api_v1/models/json/user/func.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_info.g.dart';

@JsonSerializable()
final class UserData extends ApiResponse {
  @JsonKey(name: 'Data')
  final UserInfo userData;

  UserData(super.errorCode, super.description, {required this.userData});

  factory UserData.fromJson(final Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}

@JsonSerializable()
final class UserInfo {
  @JsonKey(name: 'Id')
  final int? id;

  @JsonKey(name: 'Name')
  final String name;

  @JsonKey(name: 'Surname')
  final String surname;

  @JsonKey(name: 'Title')
  final String title;

  @JsonKey(name: 'PhoneNumber')
  final String? phoneNumber;

  @JsonKey(name: 'Function')
  final Func function;

  @JsonKey(name: 'EmailAlarm')
  final String? email;

  UserInfo({
    required this.id,
    required this.name,
    required this.surname,
    required this.title,
    required this.phoneNumber,
    required this.function,
    required this.email,
  });

  factory UserInfo.fromJson(final Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}
