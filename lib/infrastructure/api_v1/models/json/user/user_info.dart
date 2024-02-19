import 'package:json_annotation/json_annotation.dart';

part 'user_info.g.dart';

@JsonSerializable()
final class UserData {
  @JsonKey(name: 'Data')
  final UserInfo userData;

  UserData({required this.userData});

  factory UserData.fromJson(final Map<String, dynamic> json) => _$UserDataFromJson(json);

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
  final String phoneNumber;

  UserInfo({
    required this.id,
    required this.name,
    required this.surname,
    required this.title,
    required this.phoneNumber,
  });

  factory UserInfo.fromJson(final Map<String, dynamic> json) => _$UserInfoFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}
