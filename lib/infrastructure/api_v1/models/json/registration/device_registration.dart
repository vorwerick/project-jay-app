import 'package:json_annotation/json_annotation.dart';

part 'device_registration.g.dart';

@JsonSerializable()
class DeviceRegistration {
  /// [preauthKey] is registration key from sms
  @JsonKey(name: 'PreauthKey')
  final String preauthKey;

  /// [deviceKey] is device id alias firebase token
  @JsonKey(name: 'DeviceKey')
  final String deviceKey;

  DeviceRegistration(this.preauthKey, this.deviceKey);

  factory DeviceRegistration.fromJson(final Map<String, dynamic> json) => _$DeviceRegistrationFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceRegistrationToJson(this);
}
