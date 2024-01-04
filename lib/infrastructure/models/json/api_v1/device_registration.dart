import 'package:json_annotation/json_annotation.dart';

part 'device_registration.g.dart';

@JsonSerializable()
class DeviceRegistration {
  @JsonKey(name: 'PreauthKey')
  final String preauthKey;

  @JsonKey(name: 'DeviceKey')
  final String deviceKey;

  DeviceRegistration(this.preauthKey, this.deviceKey);

  factory DeviceRegistration.fromJson(Map<String, dynamic> json) => _$DeviceRegistrationFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceRegistrationToJson(this);
}
