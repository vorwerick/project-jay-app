import 'package:json_annotation/json_annotation.dart';

part 'device_configuration.g.dart';

@JsonSerializable()
class DeviceConfiguration {
  @JsonKey(name: 'DeviceKey')
  final String deviceKey;

  DeviceConfiguration(this.deviceKey);

  factory DeviceConfiguration.fromJson(Map<String, dynamic> json) => _$DeviceConfigurationFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceConfigurationToJson(this);
}
